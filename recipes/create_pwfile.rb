#
# Cookbook Name:: dovecot
# Recipe:: create_pwfile
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
extend Chef::Mixin::ShellOut


credentials = []
credentials_updated = false


passwordfile = File.open("/etc/dovecot/passwd")

local_creds = {}
passwordfile.readlines.each do |line|
  (user,crypt) = line.strip.split(":")
  local_creds[user] = crypt
end

passwordfile.close


data_bag_item(node['dovecot']['databag_name'],node['dovecot']['databag_item_name'])['users'].each do |user|
    enc_password = shell_out("/usr/bin/doveadm pw -s MD5 -p #{user[1]}").stdout
#binding.pry
    credentials_updated = true if shell_out("/usr/bin/doveadm pw -t '#{local_creds[user[0]]}' -p #{user[1]}").exitstatus != 0 
    credentials.push([user[0], enc_password.strip])
end

#binding.pry

template "/etc/dovecot/passwd" do
  source "password.erb"
  owner node['dovecot']['user']
  group node['dovecot']['group']
  mode '0750'
  variables ({
	:credentials => credentials
  })
  only_if { credentials_updated } 
end




