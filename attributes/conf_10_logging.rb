# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_logging
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

# conf.d/10-logging.conf

default['dovecot']['conf']['log_path'] = nil
default['dovecot']['conf']['info_log_path'] = nil
default['dovecot']['conf']['debug_log_path'] = nil
default['dovecot']['conf']['syslog_facility'] = nil
default['dovecot']['conf']['auth_verbose'] = nil
default['dovecot']['conf']['auth_verbose_passwords'] = nil
default['dovecot']['conf']['auth_debug'] = nil
default['dovecot']['conf']['auth_debug_passwords'] = nil
default['dovecot']['conf']['mail_debug'] = nil
default['dovecot']['conf']['verbose_ssl'] = nil
default['dovecot']['conf']['log_timestamp'] = nil
default['dovecot']['conf']['login_log_format_elements'] = nil
default['dovecot']['conf']['login_log_format'] = nil
default['dovecot']['conf']['mail_log_prefix'] = nil
default['dovecot']['conf']['deliver_log_format'] = nil
