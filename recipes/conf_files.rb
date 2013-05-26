#
# Cookbook Name:: dovecot
# Recipe:: conf_files
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

#
# required directories
#

directory node['dovecot']['lib_path'] do
  owner node['dovecot']['conf_files_user']
  group node['dovecot']['conf_files_group']
  mode '00755'
end
conf_files_dirs = []
node['dovecot']['conf_files'].each do |conf_type, conf_files|
  conf_files_dirs += conf_files.map{ |f| ::File.dirname(f) }.uniq
end
conf_files_dirs.uniq!
conf_files_dirs.each do |dir|
  directory dir do
    owner 'root'
    group node['dovecot']['group']
    mode '00755'
    only_if do dir != '.' end
  end
end

#
# config files
#

node['dovecot']['conf_files'].each do |type, conf_files|
  conf_files.each do |conf_file|
    template conf_file do
      path "#{node['dovecot']['conf_path']}/#{conf_file}"
      source "#{conf_file}.erb"
      owner node['dovecot']['conf_files_user']
      group node['dovecot']['conf_files_group']
      mode node['dovecot']['conf_files_mode']
      variables(
        :auth => node['dovecot']['auth'].to_hash,
        :protocols => node['dovecot']['protocols'].to_hash,
        :services => node['dovecot']['services'].to_hash,
        :plugins => node['dovecot']['plugins'].to_hash,
        :namespaces => node['dovecot']['namespaces'],
        :conf => node['dovecot']['conf']
      )
      notifies :reload, 'service[dovecot]'
      action :nothing
    end
  end
end

