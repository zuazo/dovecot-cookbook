# Cookbook Name:: dovecot
# Attributes:: conf_20_submission
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2016 Xabier de Zuazo
# Copyright:: Copyright (c) 2014-2019 Onddo Labs, SL.
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

# conf.d/20-submission.conf

default['dovecot']['conf']['submission_logout_format'] = nil
default['dovecot']['conf']['hostname'] = nil
default['dovecot']['conf']['submission_max_mail_size'] = nil
default['dovecot']['conf']['submission_max_recipients'] = nil
default['dovecot']['conf']['submission_client_workarounds'] = nil
default['dovecot']['conf']['submission_relay_host'] = nil
default['dovecot']['conf']['submission_relay_port'] = nil
default['dovecot']['conf']['submission_relay_user'] = nil
default['dovecot']['conf']['submission_relay_master_user'] = nil
default['dovecot']['conf']['submission_relay_password'] = nil
default['dovecot']['conf']['submission_relay_ssl'] = nil
default['dovecot']['conf']['submission_relay_ssl_verify'] = nil
default['dovecot']['conf']['submission_relay_rawlog_dir'] = nil
default['dovecot']['conf']['submission_backend_capabilities'] = nil
