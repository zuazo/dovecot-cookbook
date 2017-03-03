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
# The file credentials should be like:
# user:password:uid:gid:(gecos):home:(shell):extra_fields
# We ignore gecos and shell, all the others are included in the script but
# uid,gid,home,extra_Fields can be nil
# user:pass:<num>:<num>::<string>::<Extras string>

# Predefined Variables
credentials = []
update_credentials = false

ruby_block 'databag_to_dovecot_userdb' do
  block do
    passwd_file = node['dovecot']['conf']['password_file']
    databag_users = data_bag_item(node['dovecot']['databag_name'], node['dovecot']['databag_users_item'])['users']

    # Check if passwd file exists
    local_creds, pwfile_exists = DovecotCookbook::Pwfile.passfile_read(passwd_file)
    # Check if users on both passwd file and databag are the same
    # if not, force credentials update
    update_credentials = true unless DovecotCookbook::Pwfile.arrays_same?(databag_users.keys, local_creds.keys)
    # Check if users has a changed password, if not change it and force update
    update_credentials = DovecotCookbook::Pwfile.compile_users(databag_users,
                                                               local_creds,
                                                               pwfile_exists,
                                                               update_credentials,
                                                               credentials)
  end
  action :run
end

template node['dovecot']['conf']['password_file'] do
  source 'password.erb'
  owner node['dovecot']['user']
  group node['dovecot']['group']
  mode '0640'
  variables(
    credentials: credentials
  )
  only_if { update_credentials }
end
