# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Recipe:: user
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

user node['dovecot']['user'] do
  comment 'Dovecot mail server'
  home node['dovecot']['user_homedir']
  shell '/bin/false'
  system true
end

group node['dovecot']['group'] do
  members [node['dovecot']['user']]
  system true
  append true
end

default_login_user = node['dovecot']['conf']['default_login_user'] || 'dovenull'

group default_login_user do
  system true
end

user default_login_user do
  group default_login_user
end
