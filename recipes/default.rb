#
# Cookbook Name:: dovecot
# Recipe:: default
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
# system users
#

user node['dovecot']['user'] do
  comment 'Dovecot mail server'
  home node['dovecot']['lib_path']
  shell '/bin/false'
  system true
end

group node['dovecot']['group'] do
  members [ node['dovecot']['user'] ]
  system true
  append true
end

#
# required directories
#

directory node['dovecot']['lib_path'] do
  owner node['dovecot']['conf_files_user']
  group node['dovecot']['conf_files_group']
  mode '00755'
end
conf_files_dirs = []
node['dovecot']['conf_files'].each do |conf_type, conf_files|
  conf_files_dirs += conf_files.map{ |f| ::File.dirname(f) }.uniq
end
conf_files_dirs.uniq!
conf_files_dirs.each do |dir|
  directory dir do
    owner 'root'
    group node['dovecot']['group']
    mode '00755'
    only_if do dir != '.' end
  end
end

#
# config files
#

node['dovecot']['conf_files'].each do |type, conf_files|
  conf_files.each do |conf_file|
    template conf_file do
      path "#{node['dovecot']['conf_path']}/#{conf_file}"
      source "#{conf_file}.erb"
      owner node['dovecot']['conf_files_user']
      group node['dovecot']['conf_files_group']
      mode node['dovecot']['conf_files_mode']
      variables(
        :auth => node['dovecot']['auth'],
        :protocols => node['dovecot']['protocols'],
        :services => node['dovecot']['services'],
        :plugins => node['dovecot']['plugins'],
        :namespaces => node['dovecot']['namespaces'],
        :conf => node['dovecot']['conf']
      )
      notifies :reload, 'service[dovecot]'
      action :nothing
    end
  end
end

#
# packages
#

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  # core, imap, pop3, lmtp, ldap, sqlite
  package 'dovecot' do
    [ 'core', 'imap', 'pop3', 'lmtp', 'ldap' ].each do |conf_type|
      node['dovecot']['conf_files'][conf_type].each do |conf_file|
        notifies :create, "template[#{conf_file}]"
      end
    end
  end

  # sieve
  package 'dovecot-pigeonhole' do
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
    node['dovecot']['conf_files']['sieve'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end

when 'debian', 'ubuntu' then

  # core
  package 'dovecot-core' do
    node['dovecot']['conf_files']['core'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end
  package 'dovecot-gssapi'

  # imap
  package 'dovecot-imapd' do
    only_if do Dovecot::Protocols.enabled?('imap', node['dovecot']['protocols']) end
    node['dovecot']['conf_files']['imap'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end

  # pop3
  package 'dovecot-pop3d' do
    only_if do  Dovecot::Protocols.enabled?('pop3', node['dovecot']['protocols']) end
    node['dovecot']['conf_files']['pop3'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end

  # lmtp
  package 'dovecot-lmtpd' do
    only_if do Dovecot::Protocols.enabled?('lmtp', node['dovecot']['protocols']) end
    node['dovecot']['conf_files']['lmtp'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end

  # sieve
  package 'dovecot-sieve' do
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
    node['dovecot']['conf_files']['sieve'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end
  package 'dovecot-managesieved' do
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
  end

  # ldap
  package 'dovecot-ldap' do
    only_if do node['dovecot']['auth']['ldap'].kind_of?(Array) and node['dovecot']['auth']['ldap'].length > 0 end
    node['dovecot']['conf_files']['ldap'].each do |conf_file|
      notifies :create, "template[#{conf_file}]"
    end
  end

  # sqlite
  package 'dovecot-sqlite' do
    only_if do node['dovecot']['conf']['sql']['driver'] == 'sqlite' end
  end

else
  log('Unsupported platform, trying to guess dovecot packages') { level :warn }
  package 'dovecot'
end

package 'dovecot-mysql' do
  only_if do node['dovecot']['conf']['sql']['driver'] == 'mysql' end
end

package 'dovecot-pgsql' do
  only_if do node['dovecot']['conf']['sql']['driver'] == 'pgsql' end
end

#
# services
#

service 'dovecot' do
  supports :restart => true, :reload => true, :status => true
  action [ :enable, :start ]
end

