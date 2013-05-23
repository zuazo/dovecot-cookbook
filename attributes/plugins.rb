
default['dovecot']['conf']['mail_plugins'] = []

default['dovecot']['plugins']['mail_log'] = nil
# default['dovecot']['plugins']['mail_log'] = {
#   'mail_log_events' => 'delete undelete expunge copy mailbox_delete mailbox_rename',
#   'mail_log_fields' => 'uid box msgid size'
# }
default['dovecot']['plugins']['acl'] = nil
default['dovecot']['plugins']['quota'] = nil
default['dovecot']['plugins']['sieve'] = {
  'sieve' => '~/.dovecot.sieve',
  'sieve_dir' => '~/sieve',
}

