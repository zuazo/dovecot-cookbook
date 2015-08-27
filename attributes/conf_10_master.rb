# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_master
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

# conf.d/10-master.conf

default['dovecot']['conf']['default_process_limit'] = nil
default['dovecot']['conf']['default_client_limit'] = nil
default['dovecot']['conf']['default_vsz_limit'] = nil
default['dovecot']['conf']['default_login_user'] = nil
default['dovecot']['conf']['default_internal_user'] = nil
