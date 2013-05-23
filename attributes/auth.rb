
default['dovecot']['auth'] = {}
default['dovecot']['auth']['system'] = {}
default['dovecot']['auth']['sql']['drivers'] = []

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

