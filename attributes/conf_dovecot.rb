# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_dovecot
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

# dovecot.conf

default['dovecot']['conf']['listen'] = nil
default['dovecot']['conf']['base_dir'] = nil
default['dovecot']['conf']['instance_name'] = nil
default['dovecot']['conf']['login_greeting'] = nil
default['dovecot']['conf']['login_trusted_networks'] = nil
default['dovecot']['conf']['login_access_sockets'] = nil
default['dovecot']['conf']['auth_proxy_self'] = nil
default['dovecot']['conf']['verbose_proctitle'] = nil
default['dovecot']['conf']['shutdown_clients'] = nil
default['dovecot']['conf']['doveadm_worker_count'] = nil
default['dovecot']['conf']['doveadm_socket_path'] = nil
default['dovecot']['conf']['import_environment'] = nil
default['dovecot']['conf']['dict'] = nil
