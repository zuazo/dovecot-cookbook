
default['dovecot']['auth'] = {}

default['dovecot']['auth']['checkpassword'] = nil
# default['dovecot']['auth']['checkpassword'] = { # hash
#   'passdb' => {
#     'driver' => 'checkpassword',
#     'args' => '/usr/bin/checkpassword',
#   },
#   'userdb' => {
#     'driver' => 'prefetch',
#   },
# }
default['dovecot']['auth']['deny'] = nil
default['dovecot']['auth']['ldap'] = nil
default['dovecot']['auth']['master'] = nil
default['dovecot']['auth']['passwdfile'] = nil
default['dovecot']['auth']['sql']['drivers'] = []
default['dovecot']['auth']['system'] = {}
# default['dovecot']['auth']['system']['passdb'] = [ # array
#   {
#     # without driver
#     'args' => 'dovecot',
#   },
#   {
#     'driver' => 'passwd',
#     'args' => '',
#   },
#   {
#     'driver' => 'shadow',
#     'args' => '',
#   },
#   {
#     'driver' => 'bsdauth',
#     'args' => '',
#   },
# ]
default['dovecot']['auth']['vpopmail'] = nil

