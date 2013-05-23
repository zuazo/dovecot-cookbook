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
# packages
#

conf_files = node['dovecot']['conf_files']['core']

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  # core, imap, pop3, lmtp, ldap, sqlite
  package 'dovecot'
  conf_files +=
    node['dovecot']['conf_files']['imap'] +
    node['dovecot']['conf_files']['pop3'] +
    node['dovecot']['conf_files']['lmtp'] +
    node['dovecot']['conf_files']['ldap']

  # sieve
  if node['dovecot']['plugins'].include?('sieve')
    package 'dovecot-pigeonhole'
    conf_files += node['dovecot']['conf_files']['sieve']
  end

when 'debian', 'ubuntu' then

  # core
  package 'dovecot-core'
  package 'dovecot-gssapi'

  # imap
  if node['dovecot']['protocols'].include?('imap')
    package 'dovecot-imapd'
    conf_files += node['dovecot']['conf_files']['imap']
  end

  # pop3
  if node['dovecot']['protocols'].include?('pop3')
    package 'dovecot-pop3d'
    conf_files += node['dovecot']['conf_files']['pop3']
  end

  # lmtp
  if node['dovecot']['protocols'].include?('lmtp')
    package 'dovecot-lmtpd'
    conf_files += node['dovecot']['conf_files']['lmtp']
  end

  # sieve
  if node['dovecot']['plugins'].include?('sieve')
    package 'dovecot-sieve'
    package 'dovecot-managesieved'
    conf_files += node['dovecot']['conf_files']['sieve']
  end

  # ldap
  if node['dovecot']['auth']['ldap'].kind_of?(Array) and node['dovecot']['auth']['ldap'].length > 0
    package 'dovecot-ldap'
    conf_files += node['dovecot']['conf_files']['ldap']
  end

  # sqlite
  package 'dovecot-sqlite' do
    only_if do
      node['dovecot']['auth']['sql']['drivers'].kind_of?(Array) and
      node['dovecot']['auth']['sql']['drivers'].include?('sqlite')
    end
  end

else
  log('Unsupported platform, trying to guess dovecot packages') { level :warn }
  package 'dovecot'
end

package 'dovecot-mysql' do
  only_if do
    node['dovecot']['auth']['sql']['drivers'].kind_of?(Array) and
    node['dovecot']['auth']['sql']['drivers'].include?('mysql')
  end
end

package 'dovecot-pgsql' do
  only_if do
    node['dovecot']['auth']['sql']['drivers'].kind_of?(Array) and
    node['dovecot']['auth']['sql']['drivers'].include?('pgsql')
  end
end

#
# config files
#

conf_files.each do |conf_file|
  dir = ::File.dirname(conf_file)
  directory dir do
    owner 'root'
    group node['dovecot']['group']
    mode '00755'
    only_if do dir != '.' end
  end
  template "#{node['dovecot']['conf_path']}/#{conf_file}" do
    source "#{conf_file}.erb"
    owner 'root'
    group node['dovecot']['group']
    mode '00640'
    variables(
      :auth => node['dovecot']['auth'],
      :protocols => node['dovecot']['protocols'],
      :services => node['dovecot']['services'],
      :conf => node['dovecot']['conf']
    )
  end
end

