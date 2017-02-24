# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
# Copyright:: Copyright (c) 2016 Xabier de Zuazo
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

describe 'dovecot::user' do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  it 'creates the dovecot user' do
    expect(chef_run).to create_user('dovecot')
  end

  describe 'the dovecot user' do
    let(:user) { 'dovecot' }

    it 'has a false shell' do
      expect(chef_run).to create_user(user).with_shell('/bin/false')
    end

    it 'is a system user' do
      expect(chef_run).to create_user(user).with_system(true)
    end

    context 'on Ubuntu' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
      end

      it 'has /usr/lib/dovecot as home' do
        expect(chef_run).to create_user(user).with_home('/usr/lib/dovecot')
      end
    end # context on Ubuntu

    context 'on CentOS' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'centos', version: '5.10')
      end

      it 'has /usr/libexec/dovecot as home' do
        expect(chef_run).to create_user(user).with_home('/usr/libexec/dovecot')
      end
    end # context on CentOS

    context 'on SUSE 12' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'suse', version: '12.0')
      end

      it 'has /var/run/dovecot as home' do
        expect(chef_run).to create_user(user).with_home('/var/run/dovecot')
      end
    end # context on SUSE 12

    context 'on openSUSE 13' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'opensuse', version: '13.1')
      end

      it 'has /var/run/dovecot as home' do
        expect(chef_run).to create_user(user).with_home('/var/run/dovecot')
      end
    end # context on openSUSE 13
  end # describe the dovecot user

  it 'creates the dovecot group' do
    expect(chef_run).to create_group('dovecot')
  end

  describe 'the dovecot group' do
    let(:group) { 'dovecot' }

    it 'has dovecot user as member' do
      expect(chef_run).to create_group(group).with_members(%w(dovecot))
    end

    it 'is a system group' do
      expect(chef_run).to create_group(group).with_system(true)
    end

    describe 'group users' do
      it 'are appended' do
        expect(chef_run).to create_group(group).with_append(true)
      end
    end # describe users
  end # describe the dovecot group

  it 'creates default login group' do
    expect(chef_run).to create_group('dovenull')
  end

  it 'creates default login user' do
    expect(chef_run).to create_user('dovenull')
      .with_group('dovenull')
  end

  context 'when setting default_login_user' do
    let(:default_login_user) { 'default_login_user' }
    before do
      node.set['dovecot']['conf']['default_login_user'] = default_login_user
    end

    it 'creates default login group' do
      expect(chef_run).to create_group(default_login_user)
    end

    it 'creates default login user' do
      expect(chef_run).to create_user(default_login_user)
        .with_group(default_login_user)
    end
  end # context when setting default_login_user
end
