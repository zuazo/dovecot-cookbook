# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
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

require 'spec_helper'

def absolute_path(f)
  f[0] == '/' ? f : "/etc/dovecot/#{f}"
end

platform = os[:family].downcase
platform_version = os[:release].to_f

ssl_cert, ssl_key =
  case platform
  when 'redhat', 'centos', 'scientific', 'fedora', 'amazon'
    %w(/etc/pki/dovecot/certs/dovecot.pem /etc/pki/dovecot/private/dovecot.pem)
  when 'debian'
    platform_version >= 8 ? [nil, nil] : %w(dovecot.pem private/dovecot.pem)
  when 'ubuntu'
    if platform_version >= 15.10
      [nil, nil]
    elsif platform_version >= 14
      %w(dovecot.pem private/dovecot.pem)
    else
      %w(/etc/ssl/certs/dovecot.pem /etc/ssl/private/dovecot.pem)
    end
  when 'suse', 'opensuse'
    [nil, nil]
  else
    %w(dovecot.pem private/dovecot.pem)
  end

normal_files = %w(
  dovecot.conf
  conf.d/10-mail.conf
  conf.d/10-logging.conf
  conf.d/auth-vpopmail.conf.ext
  conf.d/auth-static.conf.ext
  conf.d/auth-dict.conf.ext
  conf.d/15-lda.conf
  conf.d/10-tcpwrapper.conf
  conf.d/10-director.conf
  conf.d/90-plugin.conf
  conf.d/90-quota.conf
  conf.d/15-mailboxes.conf
  conf.d/auth-passwdfile.conf.ext
  conf.d/auth-checkpassword.conf.ext
  conf.d/10-master.conf
  conf.d/auth-deny.conf.ext
  conf.d/90-acl.conf
  conf.d/10-auth.conf
  conf.d/auth-system.conf.ext
  conf.d/10-ssl.conf
  conf.d/auth-sql.conf.ext
  conf.d/20-imap.conf
  conf.d/auth-master.conf.ext
)

sensitive_files = %w(
  dovecot-sql.conf.ext
  dovecot-dict-auth.conf.ext
  dovecot-db.conf.ext
  dovecot-dict-sql.conf.ext
)

normal_files.each do |f|
  describe file(absolute_path(f)) do
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'dovecot' }
    it { should be_readable.by_user('dovecot') }
    it { should_not be_writable.by_user('dovecot') }
  end
end

sensitive_files.each do |f|
  describe file(absolute_path(f)) do
    it { should be_file }
    it { should be_mode 640 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'dovecot' }
    it { should be_readable.by_user('dovecot') }
    it { should_not be_writable.by_user('dovecot') }
  end
end

describe file ('/etc/dovecot/password') do
  it { should be_file} 
  it { should be_mode 640 }
  it { should be_owned_by 'dovecot' }
  it { should be_grouped_into 'dovecot' }
  it { should be_readable.by_user('dovecot') }
  it { should be_writable.by_user('dovecot') }
end

ssl_key_files = [ssl_key].compact
ssl_cert_files = [ssl_cert].compact

ssl_cert_files.each do |f|
  describe file(absolute_path(f)) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_readable.by_user('root') }
  end
end

ssl_key_files.each do |f|
  describe file(absolute_path(f)) do
    it { should be_file }
    it { should be_mode 600 }
    it { should be_owned_by 'root' }
    it { should be_readable.by_user('root') }
    it { should_not be_readable.by_user('dovecot') }
    it { should_not be_writable.by_user('dovecot') }
  end
end
