# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_files
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2013-2014 Onddo Labs, SL.
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

default['dovecot']['conf_path'] = '/etc/dovecot'
default['dovecot']['conf_files_user'] = 'root'
default['dovecot']['conf_files_group'] = node['dovecot']['group']
default['dovecot']['conf_files_mode'] = '00644'
default['dovecot']['conf']['password_file'] = \
  "#{node['dovecot']['conf_path']}/password"

default['dovecot']['sensitive_files'] = %w(
  *.conf.ext
)
default['dovecot']['sensitive_files_mode'] = '00640'

default['dovecot']['conf_files']['core'] = %w(
  conf.d/10-auth.conf
  conf.d/10-director.conf
  conf.d/10-logging.conf
  conf.d/10-mail.conf
  conf.d/10-master.conf
  conf.d/10-ssl.conf
  conf.d/10-tcpwrapper.conf
  conf.d/15-lda.conf
  conf.d/15-mailboxes.conf
  conf.d/15-replication.conf
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
  dovecot-db.conf.ext
  dovecot-dict-auth.conf.ext
  dovecot-dict-sql.conf.ext
  dovecot-sql.conf.ext
)
default['dovecot']['conf_files']['imap'] = %w(
  conf.d/20-imap.conf
)
default['dovecot']['conf_files']['pop3'] = %w(
  conf.d/20-pop3.conf
)
default['dovecot']['conf_files']['lmtp'] = %w(
  conf.d/20-lmtp.conf
)
default['dovecot']['conf_files']['sieve'] = %w(
  conf.d/20-managesieve.conf
  conf.d/90-sieve.conf
)
default['dovecot']['conf_files']['ldap'] = %w(
  dovecot-ldap.conf.ext
  conf.d/auth-ldap.conf.ext
)
