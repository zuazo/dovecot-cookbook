
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

default['dovecot']['auth']['system'] = {}
default['dovecot']['auth']['system'] = {
  'passdb' => [
  {
    'driver' => 'pam',
    'args' => 'dovecot',
  },
  {
    'driver' => 'passwd',
    'args' => '',
  },
  {
    'driver' => 'shadow',
    'args' => '',
  },
  {
    'driver' => 'bsdauth',
    'args' => '',
  },
]
}

