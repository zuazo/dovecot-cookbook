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

include_recipe 'dovecot::from_package'

# The file credentials should be like:
# user:password:uid:gid:(gecos):home:(shell):extra_fields
# We ignore gecos and shell, all the others are included in the script but
# uid,gid,home,extra_Fields can be nil
# user:pass:<num>:<num>::<string>::<Extras string>

credentials = []
credentials_updated = false

local_creds = {}
if ::File.exist?(node['dovecot']['conf']['password_file'])
  passwordfile = File.open(
    node['dovecot']['conf']['password_file'], File::RDONLY | File::CREAT, 640
  )

  passwordfile.readlines.each do |line|
    (user, crypt, uid, gid, gecos, homedir, shell, extra_fields) \
      = line.strip.split(':')
    local_creds[user] = if line.strip.split(':').length == 2
                          [crypt, uid, gid, gecos, homedir, shell, extra_fields]
                        else
                          [crypt]
                        end
  end
  passwordfile.close
else
  credentials_updated = true
end

ruby_block 'databag_to_dovecot_userdb' do
  block do
    data_bag_item(
      node['dovecot']['databag_name'], node['dovecot']['databag_users_item']
    )['users'].each do |username, user_details|
      userdbformat = if user_details.is_a?(Array)
                       [username] + user_details
                     else
                       [username, user_details, nil, nil, nil, nil, nil, nil]
                     end
      plaintextpass = userdbformat[1]
      userdbformat[1] = shell_out("/usr/bin/doveadm pw -s MD5 -p \
                              #{plaintextpass}").stdout.tr("\n", '')

      if local_creds.key?(username) && credentials_updated == false
        current_encpass = if local_creds[username].is_a?(Array)
                            local_creds[username][0]
                          else
                            local_creds[username]
                          end
        credentials_updated = true if shell_out(
          "/usr/bin/doveadm pw -t '#{current_encpass}' \
          -p #{plaintextpass}"
        ).exitstatus != 0
      else
        credentials_updated = true
      end
      credentials.push(userdbformat)
    end
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
  only_if { credentials_updated }
end
