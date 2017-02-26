# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Recipe:: conf_files
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

# required directories

directory node['dovecot']['lib_path'] do
  owner node['dovecot']['conf_files_user']
  group node['dovecot']['conf_files_group']
  mode '00755'
end
conf_files_dirs =
  node['dovecot']['conf_files'].values.reduce([]) do |r, conf_files|
    r + conf_files.map { |f| ::File.dirname(f) }
  end.uniq
conf_files_dirs.each do |dir|
  directory "#{node['dovecot']['conf_path']}/#{dir}" do
    name ::File.join(node['dovecot']['conf_path'], dir)
    recursive true
    owner node['dovecot']['conf_files_user']
    group node['dovecot']['group']
    mode '00755'
    only_if { dir != '.' }
  end
end

# config files

node['dovecot']['conf_files'].each do |type, conf_files|
  conf_files.each do |conf_file|
    template "(#{type}) #{conf_file}" do
      path conf_file
      # calculate file mode function
      def get_conf_file_mode(conf_file)
        node['dovecot']['sensitive_files'].each do |file_glob|
          if ::File.fnmatch?(file_glob, conf_file, ::File::FNM_PATHNAME)
            return node['dovecot']['sensitive_files_mode']
          end
        end
        node['dovecot']['conf_files_mode']
      end

      path ::File.join(node['dovecot']['conf_path'], conf_file)
      source "#{conf_file}.erb"
      owner node['dovecot']['conf_files_user']
      group node['dovecot']['conf_files_group']
      mode get_conf_file_mode(conf_file)
      variables(
        auth: node['dovecot']['auth'].to_hash,
        protocols: node['dovecot']['protocols'].to_hash,
        services: node['dovecot']['services'].to_hash,
        plugins: node['dovecot']['plugins'].to_hash,
        namespaces: node['dovecot']['namespaces'],
        conf: node['dovecot']['conf']
      )
      if DovecotCookbook::Conf.require?(type, node['dovecot'])
        action :create
      else
        action :delete
      end
      notifies :reload, 'service[dovecot]'
    end # template conf_file
  end # conf_files.each
end # node['dovecot']['conf_files'].each

# Already included in ::default recipe, required for ChefSpec tests
include_recipe 'dovecot::service'
