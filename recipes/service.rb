# Cookbook Name:: dovecot
# Recipe:: service
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
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

service 'dovecot' do
  service_name node['dovecot']['service']['name']
  supports Mash.new(node['dovecot']['service']['supports'])
  if node['platform'] == 'ubuntu' &&
     Gem::Requirement.new(['>= 13.10', '<= 15.10'])
                     .satisfied_by?(Gem::Version.new(node['platform_version']))
    provider Chef::Provider::Service::Upstart
  elsif node['platform'] == 'debian' && node['platform_version'].to_i < 9
    provider Chef::Provider::Service::Debian
  end
  action %i[enable start]
end
