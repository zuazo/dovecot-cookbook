# Cookbook Name:: dovecot_test
# Recipe:: attributes
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

# Dovecot SSL configuration
node.default['dovecot']['conf']['ssl'] = true
cert = ssl_certificate 'dovecot2' do
  namespace node['dovecot']
  notifies :restart, 'service[dovecot]'
end
node.default['dovecot']['conf']['ssl_cert'] = "<#{cert.chain_combined_path}"
node.default['dovecot']['conf']['ssl_key'] = "<#{cert.key_path}"

# auth.rb

node.default['dovecot']['auth']['checkpassword'] =
  {
    'passdb' => {
      'driver' => 'checkpassword',
      'args' => '/usr/bin/checkpassword'
    },
    'userdb' => { 'driver' => 'prefetch' }
  }
node.default['dovecot']['auth']['system']['passdb'] =
  [
    # without driver
    { 'args' => 'dovecot' },
    { 'driver' => 'passwd', 'args' => '' },
    { 'driver' => 'shadow', 'args' => '' },
    { 'driver' => 'bsdauth', 'args' => '' }
  ]

# conf-dovecot-dict-sql.rb

node.default['dovecot']['conf']['dict_sql']['maps'] =
  [
    {
      'pattern' => 'priv/quota/storage',
      'table' => 'quota',
      'username_field' => 'username',
      'value_field' => 'bytes'
    },
    {
      'pattern' => 'priv/quota/messages',
      'table' => 'quota',
      'username_field' => 'username',
      'value_field' => 'messages'
    },
    {
      'pattern' => 'shared/expire/$user/$mailbox',
      'table' => 'expires',
      'value_field' => 'expire_stamp',
      'fields' => {
        'username' => '$user',
        'mailbox' => '$mailbox'
      }
    }
  ]

# namespaces.rb

node.default['dovecot']['namespaces'] =
  [
    {
      'separator' => '/',
      'prefix' => '"#mbox/"',
      'location' => 'mbox:~/mail:INBOX=/var/mail/%u',
      'inbox' => true,
      'hidden' => true,
      'list' => false
    },
    {
      'separator' => '/',
      'prefix' => '',
      'location' => 'maildir:~/Maildir'
    },
    # mailboxes require dovecot >= 2.1
    # {
    #   'name' => 'inbox',
    #   'separator' => '/',
    #   'prefix' => '',
    #   'inbox' => 'yes',
    #   'inbox' => true,
    #   'mailboxes' => {
    #     'Drafts' => {
    #       'special_use' => '\Drafts'
    #     },
    #     'Junk' => {
    #       'special_use' => '\Junk'
    #     },
    #     'Trash' => {
    #       'special_use' => '\Trash'
    #     },
    #     'Sent' => {
    #       'special_use' => '\Sent'
    #     },
    #     'Sent Messages' => {
    #       'special_use' => '\Sent'
    #     },
    #     'virtual/All' => {
    #       'special_use' => '\All'
    #     },
    #     'virtual/Flagged' => {
    #       'special_use' => '\All'
    #     }
    #   }
    # }
  ]

# plugins.rb

node.default['dovecot']['plugins']['mail_log'] =
  {
    'mail_log_events' =>
      'delete undelete expunge copy mailbox_delete mailbox_rename',
    'mail_log_fields' => 'uid box msgid size'
  }
node.default['dovecot']['plugins']['sieve'] =
  {
    'sieve' => '~/.dovecot.sieve',
    'sieve_dir' => '~/sieve'
  }

# protocols.rb

node.default['dovecot']['protocols']['imap'] = {}
node.default['dovecot']['protocols']['lda'] =
  { 'mail_plugins' => %w[$mail_plugins] }

# services.rb

node.default['dovecot']['services']['director']['listeners'] =
  [
    { 'unix:login/director' => { 'mode' => '0666' } },
    { 'fifo:login/proxy-notify' => { 'mode' => '0666' } },
    { 'unix:director-userdb' => { 'mode' => '0666' } }
  ]
if node['platform'] != 'centos' # Avoid SELinux error in CentOS
  node.default['dovecot']['services']['director']['listeners'][0]['inet'] =
    { 'port' => '5432' }
end
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

include_recipe 'dovecot_test'
