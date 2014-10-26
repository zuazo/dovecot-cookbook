# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
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

require 'spec_helper'

describe 'dovecot::default' do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  %w(
    dovecot::ohai_plugin
    dovecot::user
    dovecot::from_package
    dovecot::conf_files
    dovecot::service
  ).each do |recipe|
    it "includes #{recipe} recipe" do
      expect(chef_run).to include_recipe(recipe)
    end
  end # each recipe

  xcontext 'with install from source (not yet implemented)' do
    before { node.set['dovecot']['install_from'] = 'source' }

    it 'includes dovecot::from_source recipe' do
      expect(chef_run).to include_recipe('dovecot::from_source')
    end

    it 'does not include dovecot::from_source recipe' do
      expect(chef_run).to_not include_recipe('dovecot::from_package')
    end
  end # context with install from source
end
