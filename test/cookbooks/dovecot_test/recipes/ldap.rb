# encoding: UTF-8
#
# Cookbook Name:: dovecot_test
# Recipe:: ldap
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL.
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

# Function to generate the passwords in LDAP format
def generate_ldap_password(password, salt = '12345')
  require 'digest'
  require 'base64'
  digest = Digest::SHA1.digest(password + salt)
  '{SSHA}' + Base64.encode64(digest + salt).chomp
end
recipe = self

# Create LDAP credentials
ldap_password = 'secretsauce'
ldap_credentials = {
  'bind_dn' => "cn=#{node['openldap']['cn']},#{node['openldap']['basedn']}",
  'password' => ldap_password
}

# Configure OpenLDAP server
node.default['openldap']['tls_enabled'] = false
node.default['openldap']['rootpw'] = generate_ldap_password(ldap_password)
node.default['openldap']['loglevel'] = 'any'

include_recipe 'openldap::default'

# Create some LDAP entries as an example

include_recipe 'ldap'

ldap_entry node['openldap']['basedn'] do
  attributes objectClass: %w(top dcObject organization),
             o: 'myorg',
             dc: 'myorg',
             description: 'My organization'
  credentials ldap_credentials
end

ldap_entry "ou=accounts,#{node['openldap']['basedn']}" do
  attributes objectClass: %w(top organizationalUnit),
             ou: 'accounts',
             description: 'Dovecot email accounts'
  credentials ldap_credentials
end

ldap_entry "cn=dovecot,ou=accounts,#{node['openldap']['basedn']}" do
  attributes objectClass: %w(top person),
             cn: 'dovecot',
             sn: 'dovecot'
  credentials ldap_credentials
end

# Create an email account

email_account = {
  cn: 'Ole Wobble Olson',
  sn: 'Olson',
  uid: 'wobble',
  uidNumber: '1002', # should be an string for ldap_entry
  gidNumber: '100',
  homeDirectory: '/home/wobble',
  userPassword: recipe.generate_ldap_password('w0bbl3_p4ss')
}

ldap_entry "uid=wobble,ou=accounts,#{node['openldap']['basedn']}" do
  attributes email_account.merge(objectClass: %w(top person posixAccount))
  credentials ldap_credentials
end

# Create home directory for the email account
directory email_account[:homeDirectory] do
  owner email_account[:uidNumber].to_i # should be an integer for directory
  group email_account[:gidNumber].to_i
end

# Dovecot SSL configuration
cert = ssl_certificate 'dovecot2' do
  namespace node['dovecot']
  notifies :restart, 'service[dovecot]'
end
node.default['dovecot']['conf']['ssl_cert'] = "<#{cert.chain_combined_path}"
node.default['dovecot']['conf']['ssl_key'] = "<#{cert.key_path}"

# Dovecot IMAP configuration
node.default['dovecot']['conf']['mail_location'] = 'maildir:~/Maildir'
node.default['dovecot']['protocols']['imap'] = {}
node.default['dovecot']['services']['imap-login'] =
  {
    'listeners' =>
      [
        { 'inet:imap' => { 'port' => 143 } },
        { 'inet:imaps' => { 'port' => 993, 'ssl' => true } }
      ],
    'service_count' => 1,
    'process_min_avail' => 0,
    'vsz_limit' => '64M'
  }

# Dovecot LDAP configuration
node.default['dovecot']['conf']['ldap']['auth_bind'] = true
node.default['dovecot']['conf']['ldap']['hosts'] = %w(localhost)
node.default['dovecot']['conf']['ldap']['dn'] = ldap_credentials['bind_dn']
node.default['dovecot']['conf']['ldap']['dnpass'] = ldap_credentials['password']
node.default['dovecot']['conf']['ldap']['base'] = node['openldap']['basedn']

include_recipe 'dovecot_test'
