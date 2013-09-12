
default['dovecot']['conf_path'] = '/etc/dovecot'
default['dovecot']['conf_files_user'] = 'root'
default['dovecot']['conf_files_group'] = node['dovecot']['group']
default['dovecot']['conf_files_mode'] = '00644'

default['dovecot']['conf_files']['core'] = [
  'conf.d/10-auth.conf',
  'conf.d/10-director.conf',
  'conf.d/10-logging.conf',
  'conf.d/10-mail.conf',
  'conf.d/10-master.conf',
  'conf.d/10-ssl.conf',
  'conf.d/10-tcpwrapper.conf',
  'conf.d/15-lda.conf',
  'conf.d/15-mailboxes.conf',
  'conf.d/90-acl.conf',
  'conf.d/90-plugin.conf',
  'conf.d/90-quota.conf',
  'conf.d/auth-checkpassword.conf.ext',
  'conf.d/auth-deny.conf.ext',
  'conf.d/auth-dict.conf.ext',
  'conf.d/auth-master.conf.ext',
  'conf.d/auth-passwdfile.conf.ext',
  'conf.d/auth-sql.conf.ext',
  'conf.d/auth-static.conf.ext',
  'conf.d/auth-system.conf.ext',
  'conf.d/auth-vpopmail.conf.ext',
  'dovecot.conf',
  'dovecot-db.conf.ext',
  'dovecot-dict-auth.conf.ext',
  'dovecot-dict-sql.conf.ext',
  'dovecot-sql.conf.ext',
]
default['dovecot']['conf_files']['imap'] = [
  'conf.d/20-imap.conf',
]
default['dovecot']['conf_files']['pop3'] = [
  'conf.d/20-pop3.conf',
]
default['dovecot']['conf_files']['lmtp'] = [
  'conf.d/20-lmtp.conf',
]
default['dovecot']['conf_files']['sieve'] = [
  'conf.d/20-managesieve.conf',
  'conf.d/90-sieve.conf',
]
default['dovecot']['conf_files']['ldap'] = [
  'dovecot-ldap.conf.ext',
  'conf.d/auth-ldap.conf.ext',
]

