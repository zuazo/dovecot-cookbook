# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_dovecot_ldap
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL.
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

# dovecot-ldap.conf.ext

default['dovecot']['conf']['ldap']['hosts'] = nil
default['dovecot']['conf']['ldap']['uris'] = nil
default['dovecot']['conf']['ldap']['dn'] = nil
default['dovecot']['conf']['ldap']['dnpass'] = nil
default['dovecot']['conf']['ldap']['sasl_bind'] = nil
default['dovecot']['conf']['ldap']['sasl_mech'] = nil
default['dovecot']['conf']['ldap']['sasl_realm'] = nil
default['dovecot']['conf']['ldap']['sasl_authz_id'] = nil
default['dovecot']['conf']['ldap']['tls'] = nil
default['dovecot']['conf']['ldap']['tls_ca_cert_file'] = nil
default['dovecot']['conf']['ldap']['tls_ca_cert_file'] = nil
default['dovecot']['conf']['ldap']['tls_ca_cert_dir'] = nil
default['dovecot']['conf']['ldap']['tls_cipher_suite'] = nil
default['dovecot']['conf']['ldap']['tls_cert_file'] = nil
default['dovecot']['conf']['ldap']['tls_key_file'] = nil
default['dovecot']['conf']['ldap']['tls_require_cert'] = nil
default['dovecot']['conf']['ldap']['ldaprc_path'] = nil
default['dovecot']['conf']['ldap']['debug_level'] = nil
default['dovecot']['conf']['ldap']['auth_bind'] = nil
default['dovecot']['conf']['ldap']['auth_bind_userdn'] = nil
default['dovecot']['conf']['ldap']['ldap_version'] = nil
default['dovecot']['conf']['ldap']['base'] = ''
default['dovecot']['conf']['ldap']['deref'] = nil
default['dovecot']['conf']['ldap']['scope'] = nil
default['dovecot']['conf']['ldap']['user_attrs'] = nil
default['dovecot']['conf']['ldap']['user_filter'] = nil
default['dovecot']['conf']['ldap']['pass_attrs'] = nil
default['dovecot']['conf']['ldap']['pass_filter'] = nil
default['dovecot']['conf']['ldap']['iterate_attrs'] = nil
default['dovecot']['conf']['ldap']['iterate_filter'] = nil
default['dovecot']['conf']['ldap']['default_pass_scheme'] = nil
