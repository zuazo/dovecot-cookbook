# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: default
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

default['dovecot']['install_from'] = 'package'

case node['platform_family']
when 'rhel', 'fedora'
  default['dovecot']['lib_path'] = '/usr/libexec/dovecot'
when 'suse'
  default['dovecot']['lib_path'] = '/var/run/dovecot'
# when 'debian'
else
  default['dovecot']['lib_path'] = '/usr/lib/dovecot'
end

default['dovecot']['user'] = 'dovecot'
default['dovecot']['group'] = node['dovecot']['user']
default['dovecot']['user_homedir'] = node['dovecot']['lib_path']
default['dovecot']['databag_name'] = 'dovecot'
default['dovecot']['databag_item_name'] = 'users'
