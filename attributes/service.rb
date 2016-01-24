# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: service
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
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

default['dovecot']['service']['name'] = 'dovecot'

default['dovecot']['service']['supports'] =
  if node['platform_family'] == 'suse' && node['platform_version'].to_i < 13
    { restart: true, reload: false, status: true }
  else
    { restart: true, reload: true, status: true }
  end

default['dovecot']['service']['provider'] =
  if node['platform'] == 'ubuntu' &&
     Gem::Requirement.new(['>= 13.10', '< 15'])
                     .satisfied_by?(Gem::Version.new(node['platform_version']))
    Chef::Provider::Service::Upstart
  elsif (node['platform'] == 'debian' && node['platform_version'].to_i >= 8) ||
        (node['platform'] == 'ubuntu' && node['platform_version'].to_i >= 15)
    Chef::Provider::Service::Debian
  elsif node['platform_family'] == 'suse' && node['platform_version'].to_i == 12
    Chef::Provider::Service::Redhat
  end
