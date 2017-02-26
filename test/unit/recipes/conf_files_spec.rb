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

describe 'dovecot::conf_files', order: :random do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  context 'on Ubuntu' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
    end

    it 'creates library path directory' do
      expect(chef_run).to create_directory('/usr/lib/dovecot')
    end
  end # context on Ubuntu

  context 'on CentOS' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '5.10')
    end

    it 'creates library path directory' do
      expect(chef_run).to create_directory('/usr/libexec/dovecot')
        .with_user('root')
        .with_group('dovecot')
        .with_mode('00755')
    end
  end # context on CentOS

  context 'on SUSE 12 (issue #16)' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'suse', version: '12.0')
    end

    it 'creates library path directory' do
      expect(chef_run).to create_directory('/var/run/dovecot')
    end
  end # context on SUSE 12

  context 'on openSUSE 13' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'opensuse', version: '13.1')
    end

    it 'creates library path directory' do
      expect(chef_run).to create_directory('/var/run/dovecot')
    end
  end # context on openSUSE 13

  it 'creates the conf.d directory recursively' do
    expect(chef_run).to create_directory('/etc/dovecot/conf.d')
      .with_recursive(true)
      .with_user('root')
      .with_group('dovecot')
      .with_mode('00755')
  end

  it 'avoids the creation of /etc/dovecot/. (with dot) directory' do
    expect(chef_run).to_not create_directory('/etc/dovecot/.')
  end

  shared_examples 'a template' do
    it 'creates the template' do
      expect(chef_run).to create_template("(#{type}) #{template}")
        .with_path("/etc/dovecot/#{template}")
        .with_source("#{conf_file}.erb")
        .with_owner('root')
        .with_group('dovecot')
    end

    it 'notifies dovecot service' do
      resource = chef_run.template("(#{type}) #{template}")
      expect(resource).to notify('service[dovecot]').to(:reload).delayed
    end
  end # shared example any package

  shared_examples 'a normal template' do
    it 'creates the template with normal privilages' do
      expect(chef_run).to create_template("(#{type}) #{template}")
        .with_mode('00644')
    end
  end # shared example a normal template

  shared_examples 'a sensitive template' do
    it 'creates the template with normal privilages' do
      expect(chef_run).to create_template("(#{type}) #{template}")
        .with_mode('00640')
    end
  end # shared example a sensitive template

  shared_examples 'a deleted template' do
    it 'deletes the template' do
      expect(chef_run).to delete_template("(#{type}) #{template}")
    end

    it 'notifies dovecot service' do
      resource = chef_run.template("(#{type}) #{template}")
      expect(resource).to notify('service[dovecot]').to(:reload).delayed
    end
  end # shared example a deleted template

  normal_templates = {
    'core' =>
      %w(
        conf.d/10-auth.conf
        conf.d/10-director.conf
        conf.d/10-logging.conf
        conf.d/10-mail.conf
        conf.d/10-master.conf
        conf.d/10-ssl.conf
        conf.d/10-tcpwrapper.conf
        conf.d/15-lda.conf
        conf.d/15-mailboxes.conf
        conf.d/90-acl.conf
        conf.d/90-plugin.conf
        conf.d/90-quota.conf
        conf.d/auth-checkpassword.conf.ext
        conf.d/auth-deny.conf.ext
        conf.d/auth-dict.conf.ext
        conf.d/auth-master.conf.ext
        conf.d/auth-passwdfile.conf.ext
        conf.d/auth-sql.conf.ext
        conf.d/auth-static.conf.ext
        conf.d/auth-system.conf.ext
        conf.d/auth-vpopmail.conf.ext
        dovecot.conf
      ),
    'imap' => %w(conf.d/20-imap.conf),
    'pop3' => %w(conf.d/20-pop3.conf),
    'lmtp' => %w(conf.d/20-lmtp.conf),
    'sieve' =>
      %w(
        conf.d/20-managesieve.conf
        conf.d/90-sieve.conf
      ),
    'ldap' => %w(conf.d/auth-ldap.conf.ext)
  }

  sensitive_templates = {
    'core' =>
      %w(
        dovecot-db.conf.ext
        dovecot-dict-auth.conf.ext
        dovecot-dict-sql.conf.ext
        dovecot-sql.conf.ext
      ),
    'ldap' => %w(dovecot-ldap.conf.ext)
  }

  normal_templates.each do |type, templates|
    templates.each do |template|
      context "when #{type} is required" do
        before { DovecotCookbook::Conf::Requirements.set(type, node) }

        it_behaves_like 'a normal template' do
          let(:type) { type }
          let(:template) { template }
        end
      end # when type is required

      context "when #{type} is not required", unless: type == 'core' do
        before { DovecotCookbook::Conf::Requirements.unset(type, node) }

        it_behaves_like 'a deleted template' do
          let(:type) { type }
          let(:template) { template }
        end
      end # when type is not required
    end # each template
  end # each type, templates

  sensitive_templates.each do |type, templates|
    templates.each do |template|
      context "when #{type} is required" do
        before { DovecotCookbook::Conf::Requirements.set(type, node) }

        it_behaves_like 'a sensitive template' do
          let(:type) { type }
          let(:template) { template }
        end
      end # when type is required

      context "when #{type} is not required", unless: type == 'core' do
        before { DovecotCookbook::Conf::Requirements.unset(type, node) }

        it_behaves_like 'a deleted template' do
          let(:type) { type }
          let(:template) { template }
        end
      end # when type is not required
    end # each template
  end # each type, templates
end
