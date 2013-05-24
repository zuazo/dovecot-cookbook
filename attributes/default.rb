
default['dovecot']['user'] = 'dovecot'
default['dovecot']['group'] = node['dovecot']['user']

case node['platform']
  when 'redhat','centos','scientific','fedora','suse','amazon' then
    default['dovecot']['lib_path'] = '/usr/libexec/dovecot'
  # when 'debian', 'ubuntu' then
  else
    default['dovecot']['lib_path'] = '/usr/lib/dovecot'
end

