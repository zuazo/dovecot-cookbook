
default['dovecot']['services'] = {}

default['dovecot']['services']['director'] = nil
# default['dovecot']['services']['director']['listeners'] = [
#   { 'unix:login/director' => {
#       'mode' => '0666',
#   } },
#   { 'fifo:login/proxy-notify' => {
#       'mode' => '0666',
#   } },
#   { 'unix:director-userdb' => {
#       'mode' => '0666',
#    } },
#   { 'inet' => {
#       'port' => '5432',
#   } },
# ]
default['dovecot']['services']['imap-login'] = nil
# default['dovecot']['services']['imap-login'] = {
#   'listeners' => [
#     { 'inet:imap' => {
#      # 'port' => 143,
#     } },
#     { 'inet:imaps' => {
#       # 'port' => 993,
#       # 'ssl' => true,
#     } },
#   ],
#   # 'service_count' => 1,
#   # 'process_min_avail' => 0,
#   # 'vsz_limit' => '64M',
# }
default['dovecot']['services']['pop3-login'] = nil
default['dovecot']['services']['lmtp'] = nil
default['dovecot']['services']['imap'] = nil
default['dovecot']['services']['pop3'] = nil
default['dovecot']['services']['auth'] = nil
default['dovecot']['services']['auth-worker'] = nil
default['dovecot']['services']['dict'] = nil

default['dovecot']['services']['managesieve-login'] = nil
default['dovecot']['services']['managesieve'] = nil

