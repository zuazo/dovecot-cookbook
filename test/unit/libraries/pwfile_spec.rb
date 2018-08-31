# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2017 Xabier de Zuazo
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

require_relative '../spec_helper'
require 'pwfile'

describe DovecotCookbook::Pwfile, order: :random do
  subject { DovecotCookbook::Pwfile }

  describe '.passfile_read' do
    let(:path) { '/etc/dovecot/password' }
    let(:contents) { data_file('password') }
    let(:pwfile) { instance_double('File', readlines: contents.split("\n")) }
    before do
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with(path).and_return(true)
      allow(::File).to receive(:open).and_call_original
      allow(::File).to receive(:open).with(path, any_args).and_yield(pwfile)
    end

    it 'returns an array' do
      expect(subject.passfile_read(path)).to be_a(Array)
    end

    it 'returns an array with 2 values' do
      expect(subject.passfile_read(path).length).to eq(2)
    end

    it 'reads the file creating it if it does not exist' do
      allow(::File).to receive(:open)
        .with(path, File::RDONLY | File::CREAT, 0o0640).and_yield(pwfile)
      subject.passfile_read(path)
    end

    describe 'when the file exists' do
      before do
        allow(::File).to receive(:exist?).with(path).and_return(true)
      end

      it 'returns true in the second value' do
        expect(subject.passfile_read(path)[1]).to eq(true)
      end
    end

    describe 'when the file does not exist' do
      before do
        allow(::File).to receive(:exist?).with(path).and_return(false)
        allow(pwfile).to receive(:readlines).and_return([])
      end

      it 'returns false in the second value' do
        expect(subject.passfile_read(path)[1]).to eq(false)
      end

      it 'creates the file' do
        expect(::File).to receive(:open)
          .with(path, File::RDONLY | File::CREAT, 0o0640).once.and_yield(pwfile)
        subject.passfile_read(path)
      end
    end

    describe 'with new password format' do
      let(:contents) { data_file('password') }
      let(:parsed) do
        {
          'user1' => %w[pass1 uid1 gid1 gecos1 homedir1 sh1 ex1],
          'user2' => %w[pass2 uid2 gid2 gecos2 homedir2 sh2 ex2]
        }
      end

      it 'returns the parsed content in the first value' do
        expect(subject.passfile_read(path)[0]).to eq(parsed)
      end
    end

    describe 'with old password format' do
      let(:contents) { data_file('password.old') }
      let(:parsed) do
        {
          'user1' => ['pass1', nil, nil, nil, nil, nil, nil],
          'user2' => ['pass2', nil, nil, nil, nil, nil, nil]
        }
      end

      it 'returns the parsed content in the first value' do
        expect(subject.passfile_read(path)[0]).to eq(parsed)
      end
    end
  end # .passfile_read

  describe '.arrays_same?' do
    it 'returns true for empty arrays' do
      array1 = []
      array2 = []
      expect(subject.arrays_same?(array1, array2)).to eq(true)
    end

    it 'returns false for different arrays' do
      array1 = [1, 2, 3]
      array2 = [1, 2, 4]
      expect(subject.arrays_same?(array1, array2)).to eq(false)
    end

    it 'returns true for equal arrays' do
      array1 = [1, 2, 3]
      array2 = [1, 2, 3]
      expect(subject.arrays_same?(array1, array2)).to eq(true)
    end

    it 'returns true for arrays with the same values in different order' do
      array1 = [3, 2, 1]
      array2 = [1, 2, 3]
      expect(subject.arrays_same?(array1, array2)).to eq(true)
    end

    it 'returns false when the first array is shorter' do
      array1 = [1, 2]
      array2 = [1, 2, 3]
      expect(subject.arrays_same?(array1, array2)).to eq(false)
    end

    it 'returns false when the second array is shorter' do
      array1 = [1, 2, 3]
      array2 = [1, 2]
      expect(subject.arrays_same?(array1, array2)).to eq(false)
    end
  end

  describe '.compile_users' do
    let(:enc_pass1) { 'encrypted_password_1' }
    let(:enc_pass2) { 'encrypted_password_2' }
    let(:pwtest_true_shell_out) do
      instance_double('Mixlib::ShellOut', exitstatus: 0, stdout: '')
    end
    let(:pwtest_false_shell_out) do
      instance_double('Mixlib::ShellOut', exitstatus: 1, stdout: '')
    end
    let(:pwgen1_shell_out) do
      instance_double(
        'Mixlib::ShellOut', exitstatus: 0, stdout: "#{enc_pass1}\n"
      )
    end
    let(:pwgen2_shell_out) do
      instance_double(
        'Mixlib::ShellOut', exitstatus: 0, stdout: "#{enc_pass2}\n"
      )
    end
    let(:databag_users) do
      {
        'user1' => %w[pass1 uid1 gid1 gecos1 homedir1 sh1 ex1],
        'user2' => %w[pass2 uid2 gid2 gecos2 homedir2 sh2 ex2]
      }
    end
    let(:current_users) do
      {
        'user1' => [enc_pass1] + %w[uid1 gid1 gecos1 homedir1 sh1 ex1],
        'user2' => [enc_pass2] + %w[uid2 gid2 gecos2 homedir2 sh2 ex2]
      }
    end
    let(:pwfile_exists) { true }
    let(:prev_updated) { false }
    let(:credentials) { [] }
    before do
      allow(subject).to receive(:shell_out)
        .with(/doveadm pw -t/)
        .and_return(pwtest_false_shell_out)
      allow(subject).to receive(:shell_out)
        .with(/doveadm pw -s/)
        .and_return(pwgen1_shell_out, pwgen2_shell_out)
    end

    it 'runs successfully' do
      subject
        .compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
    end

    it 'set the credentials with the passwords encrypted' do
      subject
        .compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      expect(credentials).to eq(
        [
          %w[user1 encrypted_password_1 uid1 gid1 gecos1 homedir1 sh1 ex1],
          %w[user2 encrypted_password_2 uid2 gid2 gecos2 homedir2 sh2 ex2]
        ]
      )
    end

    describe 'when the first password needs to be updated' do
      before do
        allow(subject).to receive(:shell_out)
          .with(/doveadm pw -t/)
          .and_return(pwtest_false_shell_out, pwtest_true_shell_out)
      end

      it 'runs successfully' do
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end

      it 'returns true (updated)' do
        expect(
          subject.compile_users(
            databag_users, current_users, pwfile_exists, prev_updated,
            credentials
          )
        ).to eq(true)
      end
    end # when the first password needs to be updated

    describe 'when the last password needs to be updated' do
      before do
        allow(subject).to receive(:shell_out)
          .with(/doveadm pw -t/)
          .and_return(pwtest_true_shell_out, pwtest_false_shell_out)
      end

      it 'runs successfully' do
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end

      it 'returns true (updated)' do
        expect(
          subject.compile_users(
            databag_users, current_users, pwfile_exists, prev_updated,
            credentials
          )
        ).to eq(true)
      end
    end # when the last password needs to be updated

    describe 'when no password needs to be updated' do
      before do
        allow(subject).to receive(:shell_out)
          .with(/doveadm pw -t/)
          .and_return(pwtest_true_shell_out, pwtest_true_shell_out)
      end

      it 'runs successfully' do
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end

      it 'returns false (not updated)' do
        expect(
          subject.compile_users(
            databag_users, current_users, pwfile_exists, prev_updated,
            credentials
          )
        ).to eq(false)
      end
    end # when no password needs to be updated

    describe 'when the file exists' do
      let(:pwfile_exists) { true }

      it 'runs successfully' do
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end

      it 'tests the passwords' do
        expect(subject).to receive(:shell_out)
          .with(/doveadm pw -t/).twice
          .and_return(pwtest_false_shell_out)
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end
    end # when the file exists

    describe 'when the file does not exist' do
      let(:pwfile_exists) { false }

      it 'runs successfully' do
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end

      it 'does not test the passwords' do
        expect(subject).to receive(:shell_out).with(/doveadm pw -t/).never
        subject.compile_users(
          databag_users, current_users, pwfile_exists, prev_updated, credentials
        )
      end
    end # when the file does not exist

    describe 'when updated is true' do
      let(:prev_updated) { true }

      describe 'when a password needs to be updated' do
        before do
          allow(subject).to receive(:shell_out)
            .with(/doveadm pw -t/)
            .and_return(pwtest_true_shell_out, pwtest_false_shell_out)
        end

        it 'returns true' do
          expect(
            subject.compile_users(
              databag_users, current_users, pwfile_exists, prev_updated,
              credentials
            )
          ).to eq(true)
        end
      end # when a password needs to be updated

      describe 'when no password needs to be updated' do
        before do
          allow(subject).to receive(:shell_out)
            .with(/doveadm pw -t/)
            .and_return(pwtest_true_shell_out, pwtest_true_shell_out)
        end

        it 'returns true' do
          expect(
            subject.compile_users(
              databag_users, current_users, pwfile_exists, prev_updated,
              credentials
            )
          ).to eq(true)
        end
      end # when no password needs to be updated
    end # when updated is true

    describe 'when updated is false' do
      let(:prev_updated) { false }

      describe 'when a password needs to be updated' do
        before do
          allow(subject).to receive(:shell_out)
            .with(/doveadm pw -t/)
            .and_return(pwtest_true_shell_out, pwtest_false_shell_out)
        end

        it 'returns true' do
          expect(
            subject.compile_users(
              databag_users, current_users, pwfile_exists, prev_updated,
              credentials
            )
          ).to eq(true)
        end
      end # when a password needs to be updated

      describe 'when no password needs to be updated' do
        before do
          allow(subject).to receive(:shell_out)
            .with(/doveadm pw -t/)
            .and_return(pwtest_true_shell_out, pwtest_true_shell_out)
        end

        it 'returns false' do
          expect(
            subject.compile_users(
              databag_users, current_users, pwfile_exists, prev_updated,
              credentials
            )
          ).to eq(false)
        end
      end # when no password needs to be updated
    end # when updated is false
  end # .compile_users
end
