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
require 'auth'

describe DovecotCookbook::Auth, order: :random do
  subject { DovecotCookbook::Auth }

  context '#passdb?' do
    it 'returns false for non-arrays' do
      expect(subject.passdb?(nil)).to eq(false)
      expect(subject.passdb?(4)).to eq(false)
      expect(subject.passdb?('nice')).to eq(false)
      expect(subject.passdb?(Object.new)).to eq(false)
    end

    it 'returns false for empty hashes' do
      expect(subject.passdb?({})).to eq(false)
    end

    it 'returns false for random hashes' do
      expect(subject.passdb?(random: 'hash')).to eq(false)
    end

    it 'returns false for hashes with wrong values' do
      expect(subject.passdb?('passdb' => 'wrong')).to eq(false)
    end

    it 'returns true for hashes with auth database as an array' do
      value =
        {
          'passdb' =>
            [
              { 'args' => 'dovecot' },
              { 'driver' => 'passwd', 'args' => '' },
              { 'driver' => 'shadow', 'args' => '' },
              { 'driver' => 'bsdauth', 'args' => '' }
            ]
        }
      expect(subject.passdb?(value)).to eq(true)
    end

    it 'returns true for hashes with auth database as a hash' do
      value =
        {
          'passdb' => {
            'driver' => 'checkpassword', 'args' => '/usr/bin/checkpassword'
          }
        }
      expect(subject.passdb?(value)).to eq(true)
    end
  end

  context '#userdb?' do
    it 'returns false for non-arrays' do
      expect(subject.userdb?(nil)).to eq(false)
      expect(subject.userdb?(4)).to eq(false)
      expect(subject.userdb?('nice')).to eq(false)
      expect(subject.userdb?(Object.new)).to eq(false)
    end

    it 'returns false for empty hashes' do
      expect(subject.userdb?({})).to eq(false)
    end

    it 'returns false for random hashes' do
      expect(subject.userdb?(random: 'hash')).to eq(false)
    end

    it 'returns false for hashes with wrong values' do
      expect(subject.userdb?('userdb' => 'wrong')).to eq(false)
    end

    it 'returns true for hashes with auth database as an array' do
      value =
        {
          'userdb' =>
            [
              { 'args' => 'dovecot' },
              { 'driver' => 'passwd', 'args' => '' },
              { 'driver' => 'shadow', 'args' => '' },
              { 'driver' => 'bsdauth', 'args' => '' }
            ]
        }
      expect(subject.userdb?(value)).to eq(true)
    end

    it 'returns true for hashes with auth database as a hash' do
      value =
        {
          'userdb' => {
            'driver' => 'checkpassword', 'args' => '/usr/bin/checkpassword'
          }
        }
      expect(subject.userdb?(value)).to eq(true)
    end
  end
end
