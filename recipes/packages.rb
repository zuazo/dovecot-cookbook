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

case node['platform']
when 'redhat','centos','scientific','fedora','suse','amazon' then

  # core, imap, pop3, lmtp, ldap, sqlite
  package 'dovecot' do
    [ 'core', 'imap', 'pop3', 'lmtp', 'ldap' ].each do |conf_type|
      node['dovecot']['conf_files'][conf_type].each do |conf_file|
        notifies :create, "template[#{conf_file}]", :immediately
      end
    end
  end

  # sieve
  package 'dovecot-pigeonhole' do
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
    node['dovecot']['conf_files']['sieve'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end

when 'debian', 'ubuntu' then

  # core
  package 'dovecot-core' do
    node['dovecot']['conf_files']['core'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-gssapi'

  # imap
  package 'dovecot-imapd' do
    only_if do Dovecot::Protocols.enabled?('imap', node['dovecot']['protocols']) end
    node['dovecot']['conf_files']['imap'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end

  # pop3
  package 'dovecot-pop3d' do
    only_if do  Dovecot::Protocols.enabled?('pop3', node['dovecot']['protocols']) end
    node['dovecot']['conf_files']['pop3'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end

  # lmtp
  package 'dovecot-lmtpd' do
    only_if do Dovecot::Protocols.enabled?('lmtp', node['dovecot']['protocols']) end
    node['dovecot']['conf_files']['lmtp'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end

  # sieve
  package 'dovecot-sieve' do
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
    node['dovecot']['conf_files']['sieve'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
    end
  end
  package 'dovecot-managesieved' do
    only_if do Dovecot::Plugins.required?('sieve', node['dovecot']) end
  end

  # ldap
  package 'dovecot-ldap' do
    only_if do node['dovecot']['auth']['ldap'].kind_of?(Array) and node['dovecot']['auth']['ldap'].length > 0 end
    node['dovecot']['conf_files']['ldap'].each do |conf_file|
      notifies :create, "template[#{conf_file}]", :immediately
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

