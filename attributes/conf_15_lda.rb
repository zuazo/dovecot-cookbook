# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_15_ldap
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

# conf.d/15-lda.conf

default['dovecot']['conf']['postmaster_address'] = nil
default['dovecot']['conf']['hostname'] = nil
default['dovecot']['conf']['quota_full_tempfail'] = nil
default['dovecot']['conf']['sendmail_path'] = nil
default['dovecot']['conf']['submission_host'] = nil
default['dovecot']['conf']['rejection_subject'] = nil
default['dovecot']['conf']['rejection_reason'] = nil
default['dovecot']['conf']['recipient_delimiter'] = nil
default['dovecot']['conf']['lda_original_recipient_header'] = nil
default['dovecot']['conf']['lda_mailbox_autocreate'] = nil
default['dovecot']['conf']['lda_mailbox_autosubscribe'] = nil
