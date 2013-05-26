
# conf.d/10-ssl.conf

default['dovecot']['conf']['ssl'] = nil
case node['platform']
  when 'redhat','centos','scientific','fedora','suse','amazon' then
    default['dovecot']['conf']['ssl_cert'] = '</etc/pki/dovecot/certs/dovecot.pem'
    default['dovecot']['conf']['ssl_key'] = '</etc/pki/dovecot/private/dovecot.pem'
  when 'debian'
    default['dovecot']['conf']['ssl_cert'] = '</etc/dovecot/dovecot.pem'
    default['dovecot']['conf']['ssl_key'] = '</etc/dovecot/private/dovecot.pem'
  # when 'ubuntu'
  else
    default['dovecot']['conf']['ssl_cert'] = '</etc/ssl/certs/dovecot.pem'
    default['dovecot']['conf']['ssl_key'] = '</etc/ssl/private/dovecot.pem'
end
default['dovecot']['conf']['ssl_key_password'] = nil
default['dovecot']['conf']['ssl_ca'] = nil
default['dovecot']['conf']['ssl_verify_client_cert'] = nil
default['dovecot']['conf']['ssl_cert_username_field'] = nil
default['dovecot']['conf']['ssl_parameters_regenerate'] = nil
default['dovecot']['conf']['ssl_cipher_list'] = nil

