
default['dovecot']['protocols'] = {}

default['dovecot']['protocols']['lda'] = nil
# default['dovecot']['protocols']['lda'] = {
#   'mail_plugins' => [ '$mail_plugins' ],
# }
default['dovecot']['protocols']['imap'] = {}
default['dovecot']['protocols']['lmtp'] = nil

