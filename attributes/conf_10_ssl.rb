# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_ssl
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL.
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

# conf.d/10-ssl.conf

default['dovecot']['conf']['ssl'] = \
  if node['platform_family'] == 'suse' && node['platform_version'].to_i < 13
    false
  end

case node['platform_family']
when 'rhel', 'fedora'
  default['dovecot']['conf']['ssl_cert'] = '</etc/pki/dovecot/certs/dovecot.pem'
  default['dovecot']['conf']['ssl_key'] =
    '</etc/pki/dovecot/private/dovecot.pem'
when 'debian'
  case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_f >= 15.10
      default['dovecot']['conf']['ssl_cert'] = nil
      default['dovecot']['conf']['ssl_key'] = nil
    elsif node['platform_version'].to_f >= 14.04
      default['dovecot']['conf']['ssl_cert'] = '</etc/dovecot/dovecot.pem'
      default['dovecot']['conf']['ssl_key'] =
        '</etc/dovecot/private/dovecot.pem'
    else
      default['dovecot']['conf']['ssl_cert'] = '</etc/ssl/certs/dovecot.pem'
      default['dovecot']['conf']['ssl_key'] = '</etc/ssl/private/dovecot.pem'
    end
  # when 'debian'
  else
    if node['platform_version'].to_i >= 8
      default['dovecot']['conf']['ssl_cert'] = nil
      default['dovecot']['conf']['ssl_key'] = nil
    else
      default['dovecot']['conf']['ssl_cert'] = '</etc/dovecot/dovecot.pem'
      default['dovecot']['conf']['ssl_key'] =
        '</etc/dovecot/private/dovecot.pem'
    end
  end
else
  default['dovecot']['conf']['ssl_cert'] = nil
  default['dovecot']['conf']['ssl_key'] = nil
end
default['dovecot']['conf']['ssl_key_password'] = nil
default['dovecot']['conf']['ssl_ca'] = nil
default['dovecot']['conf']['ssl_require_crl'] = nil
default['dovecot']['conf']['ssl_client_ca_dir'] = nil
default['dovecot']['conf']['ssl_client_ca_file'] = nil
default['dovecot']['conf']['ssl_verify_client_cert'] = nil
default['dovecot']['conf']['ssl_cert_username_field'] = nil
default['dovecot']['conf']['ssl_parameters_regenerate'] = nil
default['dovecot']['conf']['ssl_dh_parameters_length'] = nil
default['dovecot']['conf']['ssl_protocols'] = nil
default['dovecot']['conf']['ssl_cipher_list'] = nil
default['dovecot']['conf']['ssl_prefer_server_ciphers'] = nil
default['dovecot']['conf']['ssl_crypto_device'] = nil
default['dovecot']['conf']['ssl_options'] = nil
