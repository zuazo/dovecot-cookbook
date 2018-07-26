# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
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

describe 'dovecot::create_pwfile', order: :random do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  it 'runs databag_to_dovecot_userdb ruby block' do
    expect(chef_run).to run_ruby_block('databag_to_dovecot_userdb')
  end

  describe 'inside ruby_block[databag_to_dovecot_userdb] resource' do
    let(:chef_runner) { ChefSpec::SoloRunner.new(step_into: %w[ruby_block]) }
    let(:data_bag_users) do
      {
        'users' => {
          'dilan' => 'password1234',
          'vassilis' => ['vassilis1234', nil, nil, nil, nil, nil, nil]
        }
      }
    end
    let(:pwfile) { instance_double('File', readlines: []) }
    let(:encrypted_password) { 'encrypted_password' }
    before do
      # Stub ::File.open:
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?)
        .with('/etc/dovecot/password')
        .and_return(true)
      allow(::File).to receive(:open).and_call_original
      allow(::File).to receive(:open)
        .with('/etc/dovecot/password', any_args)
        .and_yield(pwfile)

      # Stub Data Bag:
      stub_data_bag_item('dovecot', 'users').and_return(data_bag_users)

      # Stub some commands excuted inside the ruby_block:
      stub_shell_out("/usr/bin/doveadm pw -s MD5 -p 'password1234'")
        .and_return_stdout(encrypted_password)
      stub_shell_out("/usr/bin/doveadm pw -s MD5 -p 'vassilis1234'")
        .and_return_stdout(encrypted_password)
    end

    it 'creates password file template' do
      expect(chef_run).to create_template('/etc/dovecot/password')
        .with_path('/etc/dovecot/password')
        .with_source('password.erb')
        .with_owner('dovecot')
        .with_group('dovecot')
        .with_mode('0640')
        .with_sensitive(true)
    end
  end
end
