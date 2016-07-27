# encoding: UTF-8
#
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

require_relative '../spec_helper'

describe 'dovecot::from_package' do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  shared_examples 'any package' do
    context 'with ohai build options enabled' do
      before { node.set['dovecot']['ohai_plugin']['build-options'] = true }

      it 'notifies ohai plugin' do
        resource = chef_run.package(pkg)
        expect(resource).to notify('ohai[dovecot]').to(:reload)
          .immediately
      end
    end # context with ohai build options enabled
  end # shared example any package

  shared_examples 'core package' do
    it_behaves_like 'any package'

    context 'with ohai build options disabled' do
      before { node.set['dovecot']['ohai_plugin']['build-options'] = false }

      it 'notifies ohai plugin' do
        resource = chef_run.package(pkg)
        expect(resource).to notify('ohai[dovecot]').to(:reload)
          .immediately
      end
    end # context with ohai build options disabled
  end

  shared_examples 'non-core package' do
    it_behaves_like 'any package'

    context 'with ohai build options disabled' do
      before { node.set['dovecot']['ohai_plugin']['build-options'] = false }

      it 'notifies ohai plugin' do
        resource = chef_run.package(pkg)
        expect(resource).to_not notify('ohai[dovecot]')
      end
    end # context with ohai build options disabled
  end

  context 'when node[dovecot][packages][type] is an array' do
    before { node.set['dovecot']['packages']['core'] = %w(my_package) }

    it 'does not fail' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the package' do
      expect(chef_run).to install_package('(core) my_package')
    end
  end

  context 'when node[dovecot][packages][type] is a string' do
    before { node.set['dovecot']['packages']['core'] = 'my_package' }

    it 'does not fail' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the package' do
      expect(chef_run).to install_package('(core) my_package')
    end
  end

  context 'when node[dovecot][packages][type] has bad format' do
    before { node.set['dovecot']['packages']['type'] = Mash.new }

    it 'fails' do
      expect { chef_run }.to raise_error(/should contain an array/)
    end
  end

  context 'on Ubuntu' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
    end

    %w(
      dovecot-core
      dovecot-gssapi
    ).each do |pkg|
      it "installs #{pkg} package" do
        expect(chef_run).to install_package("(core) #{pkg}")
          .with_package_name(pkg)
      end

      describe "#{pkg} package" do
        let(:pkg) { "(core) #{pkg}" }
        it_behaves_like 'core package'
      end # describe pkg package
    end # each pkg

    {
      'imap' => %w(dovecot-imapd),
      'pop3' => %w(dovecot-pop3d),
      'lmtp' => %w(dovecot-lmtpd),
      'sieve' => %w(dovecot-sieve dovecot-managesieved),
      'ldap' => %w(dovecot-ldap),
      'sqlite' => %w(dovecot-sqlite),
      'mysql' => %w(dovecot-mysql),
      'pgsql' => %w(dovecot-pgsql)
    }.each do |type, pkgs|
      pkgs.each do |pkg|
        context "when #{pkg} is required" do
          before { Dovecot::Conf::Requirements.set(type, node) }

          it "installs dovecot #{pkg} package" do
            expect(chef_run).to install_package("(#{type}) #{pkg}")
              .with_package_name(pkg)
          end

          describe "#{pkg} package" do
            let(:pkg) { "(#{type}) #{pkg}" }
            it_behaves_like 'non-core package'
          end # describe pkg package
        end # context when pkg is required
      end # each pkg
    end # each type, pkgs
  end # context on Ubuntu

  context 'on CentOS' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '5.10')
    end

    it 'installs dovecot package' do
      expect(chef_run).to install_package('(core) dovecot')
    end

    {
      'sieve' => %w(dovecot-pigeonhole),
      'mysql' => %w(dovecot-mysql),
      'pgsql' => %w(dovecot-pgsql)
    }.each do |type, pkgs|
      pkgs.each do |pkg|
        context "when #{pkg} is required" do
          before { Dovecot::Conf::Requirements.set(type, node) }

          it "installs dovecot #{pkg} package" do
            expect(chef_run).to install_package("(#{type}) #{pkg}")
              .with_package_name(pkg)
          end

          describe "#{pkg} package" do
            let(:pkg) { "(#{type}) #{pkg}" }
            it_behaves_like 'non-core package'
          end # describe pkg package
        end # context when pkg is required
      end # each pkg
    end # each type, pkgs
  end # context on CentOS

  context 'on SUSE 12' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'suse', version: '12.0')
    end

    it 'installs dovecot package' do
      expect(chef_run).to install_package('(core) dovecot')
    end

    {
      'sqlite' => %w(dovecot-backend-sqlite),
      'mysql' => %w(dovecot-backend-mysql),
      'pgsql' => %w(dovecot-backend-pgsql)
    }.each do |type, pkgs|
      pkgs.each do |pkg|
        context "when #{pkg} is required" do
          before { Dovecot::Conf::Requirements.set(type, node) }

          it "installs dovecot #{pkg} package" do
            expect(chef_run).to install_package("(#{type}) #{pkg}")
              .with_package_name(pkg)
          end

          describe "#{pkg} package" do
            let(:pkg) { "(#{type}) #{pkg}" }
            it_behaves_like 'non-core package'
          end # describe pkg package
        end # context when pkg is required
      end # each pkg
    end # each type, pkgs
  end # context on SUSE 12

  context 'on openSUSE 13' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'opensuse', version: '13.1')
    end

    it 'installs dovecot package' do
      expect(chef_run).to install_package('(core) dovecot')
    end

    {
      'sqlite' => %w(dovecot-backend-sqlite),
      'mysql' => %w(dovecot-backend-mysql),
      'pgsql' => %w(dovecot-backend-pgsql)
    }.each do |type, pkgs|
      pkgs.each do |pkg|
        context "when #{pkg} is required" do
          before { Dovecot::Conf::Requirements.set(type, node) }

          it "installs dovecot #{pkg} package" do
            expect(chef_run).to install_package("(#{type}) #{pkg}")
              .with_package_name(pkg)
          end

          describe "#{pkg} package" do
            let(:pkg) { "(#{type}) #{pkg}" }
            it_behaves_like 'non-core package'
          end # describe pkg package
        end # context when pkg is required
      end # each pkg
    end # each type, pkgs
  end # context on SUSE 12

  context 'on Arch' do
    # Arch still not supported by fauxhai
    before do
      node.automatic['platform_family'] = 'arch'
      node.automatic['platform'] = 'arch'
    end

    it 'installs dovecot package' do
      expect(chef_run).to install_package('(core) dovecot')
    end

    {
      'sieve' => %w(pigeonhole)
    }.each do |type, pkgs|
      pkgs.each do |pkg|
        context "when #{pkg} is required" do
          before { Dovecot::Conf::Requirements.set(type, node) }

          it "installs dovecot #{pkg} package" do
            expect(chef_run).to install_package("(#{type}) #{pkg}")
              .with_package_name(pkg)
          end

          describe "#{pkg} package" do
            let(:pkg) { "(#{type}) #{pkg}" }
            it_behaves_like 'non-core package'
          end # describe pkg package
        end # context when pkg is required
      end # each pkg
    end # each type, pkgs
  end # context on Arch
end
