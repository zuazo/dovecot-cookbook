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

describe 'dovecot::service', order: :random do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  it 'enables dovecot service' do
    expect(chef_run).to enable_service('dovecot')
  end

  it 'starts dovecot service' do
    expect(chef_run).to start_service('dovecot')
  end

  describe 'the dovecot service' do
    let(:service) { 'dovecot' }

    it 'supports restart, reload and status' do
      expect(chef_run).to enable_service(service)
        .with_supports(Mash.new(restart: true, reload: true, status: true))
    end

    it 'uses the default provider' do
      expect(chef_run).to enable_service(service).with_provider(nil)
    end

    context 'on SUSE 12 (issue #16)' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'suse', version: '12.0')
      end

      it 'uses the RedHat provider' do
        expect(chef_run).to enable_service(service)
          .with_provider(Chef::Provider::Service::Redhat)
      end

      it 'does not support reload' do
        expect(chef_run).to enable_service(service)
          .with_supports(Mash.new(restart: true, reload: false, status: true))
      end
    end

    context 'on openSUSE 13' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'opensuse', version: '13.1')
      end

      it 'uses the default provider' do
        expect(chef_run).to enable_service(service).with_provider(nil)
      end

      it 'supports reload' do
        expect(chef_run).to enable_service(service)
          .with_supports(Mash.new(restart: true, reload: true, status: true))
      end
    end

    context 'on Ubuntu 12.04' do
      before do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
      end

      it 'does not use the upstart provider' do
        expect(chef_run).to enable_service(service).with_provider(nil)
      end

      it 'supports reload' do
        expect(chef_run).to enable_service(service)
          .with_supports(Mash.new(restart: true, reload: true, status: true))
      end
    end

    context 'on Ubuntu 14.04' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04')
      end

      it 'uses the upstart provider' do
        expect(chef_run).to enable_service(service)
          .with_provider(Chef::Provider::Service::Upstart)
      end

      it 'supports reload' do
        expect(chef_run).to enable_service(service)
          .with_supports(Mash.new(restart: true, reload: true, status: true))
      end
    end # context on Ubuntu 13.10

    context 'on Ubuntu 15.04' do
      # Ubuntu 15.04 still not supported by fauxhai
      before do
        node.automatic['platform_family'] = 'debian'
        node.automatic['platform'] = 'ubuntu'
        node.automatic['platform_version'] = '15.04'
      end

      it 'uses the debian provider' do
        expect(chef_run).to enable_service(service)
          .with_provider(Chef::Provider::Service::Debian)
      end

      it 'supports reload' do
        expect(chef_run).to enable_service(service)
          .with_supports(Mash.new(restart: true, reload: true, status: true))
      end
    end # context on Ubuntu 15.04

    context 'on Debian 8' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: 'debian', version: '8.0')
      end

      it 'uses the debian provider' do
        expect(chef_run).to enable_service(service)
          .with_provider(Chef::Provider::Service::Debian)
      end

      it 'supports reload' do
        expect(chef_run).to enable_service(service)
          .with_supports(Mash.new(restart: true, reload: true, status: true))
      end
    end # context on Debian 8
  end # context the dovecot service
end
