#
# Cookbook Name:: dovecot
# Recipe:: packages
#
# Copyright 2013, Onddo Labs, Sl.
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

#
# packages
#

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  # core, imap, pop3, lmtp, ldap, sqlite
  ruby_block 'package-dovecot-core' do
    block {}
    notifies :install, 'package[dovecot]', :immediately
    [ 'core', 'imap', 'pop3', 'lmtp', 'ldap' ].each do |conf_type|
      node['dovecot']['conf_files'][conf_type].each do |conf_file|
        notifies :create, "template[#{conf_file}]", :immediately
      end
    end
  end
  package 'dovecot' do action :nothing end

  # sieve
  ruby_block 'package-dovecot-sieve' do
    block {}
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
    notifies :install, 'package[dovecot-pigeonhole]', :immediately
    node['dovecot']['conf_files']['sieve'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-pigeonhole' do action :nothing end

when 'debian', 'ubuntu' then

  # core
  ruby_block 'package-dovecot-core' do
    block {}
    notifies :install, 'package[dovecot-core]', :immediately
    notifies :install, 'package[dovecot-gssapi]', :immediately
    node['dovecot']['conf_files']['core'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-core' do action :nothing end
  package 'dovecot-gssapi' do action :nothing end

  # imap
  ruby_block 'package-dovecot-imap' do
    block {}
    only_if do Dovecot::Protocols.enabled?('imap', node['dovecot']['protocols']) end
    notifies :install, 'package[dovecot-imapd]', :immediately
    node['dovecot']['conf_files']['imap'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-imapd' do action :nothing end

  # pop3
  ruby_block 'package-dovecot-pop3d' do
    block {}
    only_if do Dovecot::Protocols.enabled?('pop3', node['dovecot']['protocols']) end
    notifies :install, 'package[dovecot-pop3d]', :immediately
    node['dovecot']['conf_files']['pop3'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-pop3d' do action :nothing end

  # lmtp
  ruby_block 'package-dovecot-lmtpd' do
    block {}
    only_if do Dovecot::Protocols.enabled?('lmtp', node['dovecot']['protocols']) end
    notifies :install, 'package[dovecot-lmtpd]', :immediately
    node['dovecot']['conf_files']['lmtp'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-lmtpd' do action :nothing end

  # sieve
  ruby_block 'package-dovecot-sieve' do
    block {}
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
    notifies :install, 'package[dovecot-sieve]', :immediately
    notifies :install, 'package[dovecot-managesieved]', :immediately
    node['dovecot']['conf_files']['sieve'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-sieve' do action :nothing end
  package 'dovecot-managesieved' do action :nothing end

  # ldap
  ruby_block 'package-dovecot-ldap' do
    block {}
    only_if do node['dovecot']['auth']['ldap'].kind_of?(Array) and node['dovecot']['auth']['ldap'].length > 0 end
    notifies :install, 'package[dovecot-ldap]', :immediately
    node['dovecot']['conf_files']['ldap'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-ldap' do action :nothing end

  # sqlite
  ruby_block 'package-dovecot-sqlite' do
    block {}
    only_if do node['dovecot']['conf']['sql']['driver'] == 'sqlite' end
    notifies :install, 'package[dovecot-sqlite]', :immediately
  end
  package 'dovecot-sqlite' do action :nothing end

else
  Chef::Application.fatal!("Unsupported platform: #{node['platform']}");
end

ruby_block 'package-dovecot-mysql' do
  block {}
  only_if do node['dovecot']['conf']['sql']['driver'] == 'mysql' end
  notifies :install, 'package[dovecot-mysql]', :immediately
end
package 'dovecot-mysql' do action :nothing end

ruby_block 'package-dovecot-pgsql' do
  block {}
  only_if do node['dovecot']['conf']['sql']['driver'] == 'pgsql' end
  notifies :install, 'package[dovecot-pgsql]', :immediately
end
package 'dovecot-pgsql' do action :nothing end

