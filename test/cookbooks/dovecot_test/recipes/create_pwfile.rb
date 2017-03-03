# encoding: UTF-8
#
# Cookbook Name:: dovecot_test
# Recipe:: default
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2013-2015 Onddo Labs, SL.
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

maildir = '/var/dovecot/vmail'


node.default['dovecot']['auth']['passwdfile'] = {
 'passdb' => {
    'driver' => 'passwd-file',
    'args'   => node['dovecot']['conf']['password_file']
 },
 'userdb' => {
    'driver' => 'passwd-file',
    'args'  => "username_format=%u #{node['dovecot']['conf']['password_file']}",
    'default_fields' => "home=#{maildir}/%d/%n"
 }
}
node.default['dovecot']['services'] = {
  'auth' => {
    'listeners' => [
      {
        'unix:auth-passdb' => {
          'mode' => '0600',
          'user' => 'dovecot',
          'group' => 'dovecot'
        }
      }
    ]
  },
  'config' => {
    'listeners' => [
      {
        'unix:config' => {
         'user' => 'dovecot'
        }
      }
    ]
  }
}

node.default['dovecot']['protocols']['imap'] = {}
node.default['dovecot']['protocols']['pop3'] = {}
node.default['dovecot']['protocols']['lda'] =
  { 'mail_plugins' => %w($mail_plugins) }
node.default['dovecot']['conf']['mail_uid'] = 'dovecot'
node.default['dovecot']['conf']['mail_gid'] = 'dovecot'
node.default['dovecot']['conf']['mail_location'] = 'maildir:~/Maildir'

include_recipe 'dovecot_test'
include_recipe 'dovecot::create_pwfile'

['/var/dovecot', maildir].each do |dir_to_create|
  directory dir_to_create do
    owner node.default['dovecot']['user']
    group node.default['dovecot']['user']
    action :create
  end
end

# Required for integration tests:
package 'lsof'
include_recipe 'netstat'
