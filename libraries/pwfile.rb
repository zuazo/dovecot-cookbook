# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Library:: pwfile
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2013-2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module DovecotCookbook
  # Helper module to check password file and import it
  module Pwfile
    extend Chef::Mixin::ShellOut

    # Checks if the file exists locally.
    #
    # @param localdata [String] File path.
    # @return [Boolean] Whether the file exists.
    def self.exists?(localdata)
      ::File.exist?(localdata)
    end

    # Reads a password file from this and it returns its contents as a hash.
    #
    # @param inputfile [String] File path.
    # @return [Hash] The file contents.
    def self.file_to_hash(inputfile)
      output_entries = {}
      File.open(inputfile, File::RDONLY | File::CREAT, 0640) do |passwordfile|
        passwordfile.readlines.each do |line|
          user, data = fileline_to_userdb_hash(line)
          output_entries[user] = data
        end
      end
      output_entries
    end

    # Returns Password file in userdb style hash and if exists.
    #
    # @param input [String] The path of the file.
    # @return [Array] An array with two values: The input in hash format and
    #   whether the file exists on the disk or not.
    # @api public
    def self.passfile_read(input)
      [file_to_hash(input), exists?(input)]
    end

    # Returns a hash of details taken from the userdb file line.
    #
    # @param input [String] A line of input.
    def self.fileline_to_userdb_hash(input)
      data = [nil] * 7
      if input.strip.split(':').length == 2
        user, data[0] = input.strip.split(':')
      else
        user = input.strip.split(':')[0]
        data = input.strip.split(':')[1..7]
      end
      [user, data]
    end

    # Returns an array with 8 values to use with user copy.
    #
    # @param key [String] The name, or the first value to be included in the
    #   final array.
    # @param value [String, Array] An array of values to be added to the key.
    # @return [Array] An array of length 8 with the format
    #   `[key, value1, value2, ..., value7]`. The array is filled with `nil`
    #   values if there are less than 7 values in `value` array.
    def self.dbentry_to_array(key, value)
      if value.is_a?(Array)
        [key] + (value + ([nil] * (7 - value.size)))
      else
        [key, value] + ([nil] * 6)
      end
    end

    # Checks if a plain text password matches a specific encrypted password.
    #
    # @param hashed_pw [String] The password encrypted.
    # @param plaintext_pw [String] The password in clear text.
    # @return [Boolean] Whether the two passwords are the same.
    def self.password_valid?(hashed_pw, plaintext_pw)
      shell_out("/usr/bin/doveadm pw -t '#{hashed_pw}' -p '#{plaintext_pw}'")
        .exitstatus == 0
    end

    # Checks if two arrays contain the same values.
    #
    # @param array1 [Array] The first array.
    # @param array2 [Array] The second array.
    # @return [Boolean] Returns `true` if both arrays contain the same values.
    # @api public
    def self.arrays_same?(array1, array2)
      (array1 - array2).empty? && (array2 - array1).empty?
    end

    # Encrypts a plain text password.
    #
    # @param plaintextpass [String] The password to encrypt.
    # @return [String] The password encrypted.
    def self.encrypt_password(plaintextpass)
      shell_out("/usr/bin/doveadm pw -s MD5 -p '#{plaintextpass}'")
        .stdout.tr("\n", '')
    end

    # Generates the user password on the disk password file only if required.
    #
    # @param input_creds [Array] Credentials on disk for a user.
    # @param plaintextpass [String] The password to encrypt.
    # @param updated [Boolean] Previous values of whether any user has been
    #   updated.
    # @param file_exists [Boolean] Whether the local file already exists.
    # @return [Array] An array with two values: the encrypted password and
    #   whether it needs to be updated on disk.
    def self.generate_userpass(input_creds, plaintextpass, updated, file_exists)
      if !input_creds.nil? && file_exists == true &&
         password_valid?(input_creds[0], plaintextpass)
        return [input_creds[0], updated]
      end
      [encrypt_password(plaintextpass), true]
    end

    # Update users credentials only if required.
    #
    # The `credentials` parameter is updated with all the credentials.
    #
    # @param databag_users [Hash] User list read from the Data Bag.
    # @param current_users [Hash] User list read from a file on the disk.
    # @param pwfile_exists [Boolean] Whether exists a file on the disk.
    # @param prev_updated [Boolean] Previous values of this function return
    #   value.
    # @param credentials [Array] The list of credentials. This value is
    #   populated by this function with the generated (encrypted) credentials
    #   ready to be written to disk.
    # @return [Boolean] `true` if any user has been updated.
    # @api public
    def self.compile_users(
      databag_users, current_users, pwfile_exists, prev_updated, credentials
    )
      databag_users.reduce(prev_updated) do |updated, (username, user_details)|
        current_user = dbentry_to_array(username, user_details)
        current_user[1], updated =
          generate_userpass(
            current_users[username], current_user[1], updated, pwfile_exists)
        credentials.push(current_user)
        updated
      end
    end
  end
end
