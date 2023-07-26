# Cookbook Name:: dovecot
# Recipe:: ohai_plugin
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

build_options = node['dovecot']['ohai_plugin']['build-options']

# dummy resource to be able to notify reload action to the ohai plugin
ohai 'dovecot' do
  action :nothing
end

ohai_plugin 'dovecot' do
  source_file 'ohai_plugins/dovecot.rb.erb'
  resource :template
  variables enable_build_options: build_options
end
