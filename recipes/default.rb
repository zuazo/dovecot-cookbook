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

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  # core, imap, pop3, lmtp, ldap, sqlite
  package 'dovecot' do
    action :install
  end

  # sieve
  package 'dovecot-pigeonhole' do
    action :install
    only_if do node['dovecot']['plugins'].include?('sieve') end
  end

when 'debian', 'ubuntu' then

  # core
  package 'dovecot-core' do
    action :install
  end
  package 'dovecot-gssapi' do
    action :install
  end

  # imap
  package 'dovecot-imapd' do
    action :install
    only_if do node['dovecot']['protocols'].include?('imap') end
  end

  # pop3
  package 'dovecot-pop3d' do
    action :install
    only_if do node['dovecot']['protocols'].include?('pop3') end
  end

  # lmtp
  package 'dovecot-lmtpd' do
    action :install
    only_if do node['dovecot']['protocols'].include?('lmtp') end
  end

  # sieve
  package 'dovecot-sieve' do
    action :install
    only_if do node['dovecot']['plugins'].include?('sieve') end
  end
  package 'dovecot-managesieved' do
    action :install
    only_if do node['dovecot']['plugins'].include?('sieve') end
  end

  package 'dovecot-ldap' do
    action :install
    only_if do
      node['dovecot']['auth']['ldap'].kind_of?(Array) and
      node['dovecot']['auth']['ldap'].length > 0
    end
  end

  package 'dovecot-sqlite' do
    action :install
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
  action :install
  only_if do
    node['dovecot']['auth']['sql']['drivers'].kind_of?(Array) and
    node['dovecot']['auth']['sql']['drivers'].include?('mysql')
  end
end

package 'dovecot-pgsql' do
  action :install
  only_if do
    node['dovecot']['auth']['sql']['drivers'].kind_of?(Array) and
    node['dovecot']['auth']['sql']['drivers'].include?('pgsql')
  end
end

