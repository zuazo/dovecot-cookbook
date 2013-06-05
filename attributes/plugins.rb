
default['dovecot']['conf']['mail_plugins'] = []

default['dovecot']['plugins']['sieve'] = {
  'sieve' => '~/.dovecot.sieve',
  'sieve_dir' => '~/sieve',
}

