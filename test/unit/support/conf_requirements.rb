# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL.
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
  module Conf
    # Helper module to force some requirements
    module Requirements
      def self.enable_protocol(node, proto)
        node.normal['dovecot']['protocols'][proto] = Mash.new
      end

      def self.disable_protocol(node, proto)
        node.normal['dovecot']['protocols'][proto] = 'disabled'
      end

      def self.enable_sieve(node)
        node.normal['dovecot']['conf']['mail_plugins'] = %w[sieve]
      end

      def self.disable_sieve(node)
        node.normal['dovecot']['conf']['mail_plugins'] = %w[]
      end

      def self.enable_ldap(node)
        node.normal['dovecot']['conf']['ldap']['auth_bind'] = true
      end

      def self.disable_ldap(node)
        node.normal['dovecot']['conf']['ldap']['auth_bind'] = 'disabled'
      end

      def self.enable_driver(node, driver)
        node.normal['dovecot']['conf']['sql']['driver'] = driver
      end

      # def self.disable_driver(node)
      #   node.normal['dovecot']['conf']['sql']['driver'] = 'disabled'
      # end

      def self.set(type, node)
        case type
        when 'imap', 'pop3', 'lmtp' then enable_protocol(node, type)
        when 'sieve' then enable_sieve(node)
        when 'ldap' then enable_ldap(node)
        when 'sqlite', 'mysql', 'pgsql' then enable_driver(node, type)
        end
      end

      def self.unset(type, node)
        case type
        when 'imap', 'pop3', 'lmtp' then disable_protocol(node, type)
        when 'sieve' then disable_sieve(node)
        when 'ldap' then disable_ldap(node)
          # when 'sqlite', 'mysql', 'pgsql' then disable_driver(node)
        end
      end
    end
  end
end
