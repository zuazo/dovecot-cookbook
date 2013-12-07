#
# Cookbook Name:: dovecot
# Recipe:: ohai_plugin
#
# Copyright 2013, Onddo Labs, Sl.
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

ohai 'reload_dovecot' do
  plugin 'dovecot'
  action :nothing
end

template "#{node['ohai']['plugin_path']}/dovecot.rb" do
  source 'ohai_plugins/dovecot.rb.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(
    :enable_build_options => node['dovecot']['ohai_plugin']['build-options']
  )
  notifies :reload, 'ohai[reload_dovecot]', :immediately
end

include_recipe 'ohai::default'
