# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_auth
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

# conf.d/10-auth.conf

default['dovecot']['conf']['disable_plaintext_auth'] = nil
default['dovecot']['conf']['auth_cache_size'] = nil
default['dovecot']['conf']['auth_cache_ttl'] = nil
default['dovecot']['conf']['auth_cache_negative_ttl'] = nil
default['dovecot']['conf']['auth_realms'] = nil
default['dovecot']['conf']['auth_default_realm'] = nil
default['dovecot']['conf']['auth_username_chars'] = nil
default['dovecot']['conf']['auth_username_translation'] = nil
default['dovecot']['conf']['auth_username_format'] = nil
default['dovecot']['conf']['auth_master_user_separator'] = nil
default['dovecot']['conf']['auth_anonymous_username'] = nil
default['dovecot']['conf']['auth_worker_max_count'] = nil
default['dovecot']['conf']['auth_gssapi_hostname'] = nil
default['dovecot']['conf']['auth_krb5_keytab'] = nil
default['dovecot']['conf']['auth_use_winbind'] = nil
default['dovecot']['conf']['auth_winbind_helper_path'] = nil
default['dovecot']['conf']['auth_failure_delay'] = nil
default['dovecot']['conf']['auth_ssl_require_client_cert'] = nil
default['dovecot']['conf']['auth_mechanisms'] = 'plain'
