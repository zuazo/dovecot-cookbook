
default['dovecot']['auth'] = {}
default['dovecot']['auth']['system'] = {}
default['dovecot']['auth']['sql']['drivers'] = []

default['dovecot']['auth']['checkpassword'] = nil
# default['dovecot']['auth']['checkpassword'] = {
#   'passdb' => {
#     'driver' => 'checkpassword',
#     'args' => '/usr/bin/checkpassword',
#   },
#   'userdb' => {
#     'driver' => 'prefetch',
#   },
# }

