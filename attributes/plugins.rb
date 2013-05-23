
default['dovecot']['mail_plugins'] = [ 'sieve' ]

default['dovecot']['plugins']['sieve'] = {}

default['dovecot']['plugins']['mail_log'] = nil
# default['dovecot']['plugins']['mail_log'] = {
#   'mail_log_events' => 'delete undelete expunge copy mailbox_delete mailbox_rename',
#   'mail_log_fields' => 'uid box msgid size'
# }
default['dovecot']['plugins']['acl'] = nil

