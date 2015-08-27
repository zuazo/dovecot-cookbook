# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_director
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

# conf.d/10-director.conf

default['dovecot']['conf']['director_servers'] = nil
default['dovecot']['conf']['director_mail_servers'] = nil
default['dovecot']['conf']['director_user_expire'] = nil
default['dovecot']['conf']['director_doveadm_port'] = nil
default['dovecot']['conf']['director_username_hash'] = nil
