
default['dovecot']['conf']['dict_sql']['connect'] = nil
# default['dovecot']['conf']['dict_sql']['connect'] = 'host=localhost dbname=mails user=testuser password=pass'
default['dovecot']['conf']['dict_sql']['maps'] = nil
# default['dovecot']['conf']['dict_sql']['maps'] = [
#   {
#     'pattern' => 'priv/quota/storage',
#     'table' => 'quota',
#     'username_field' => 'username',
#     'value_field' => 'bytes',
#   },
#   {
#     'pattern' => 'priv/quota/messages',
#     'table' => 'quota',
#     'username_field' => 'username',
#     'value_field' => 'messages',
#   },
#   {
#     'pattern' => 'shared/expire/$user/$mailbox',
#     'table' => 'expires',
#     'value_field' => 'expire_stamp',
#     'fields' => {
#       'username' => '$user',
#       'mailbox' => '$mailbox',
#     },
#   },
# ]

