# encoding: UTF-8
#
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


  context 'when the module runs' do
    it 'creates a file' do
      expect(chef_run). to create_template('/etc/dovecot/password')
        .with_path('/etc/dovecot/password')
        .with_source('password.erb')
    end
  end

#  context 'when the data_bag is not stubbed' do
#    it 'raises an exception' do
#      expect(chef_run).to raise_error(ChefSpec::Error::DataBagNotStubbed)
#    end
#  end

=begin
  context 'stub array test' do
    it 'does not raise an exception' do
      stub_data_bag('dovecot').and return([
        { id: 1, comment: 'users' }
      ])
      expect { chef_run }.to_not raise_error
    end
  end
=end
end
