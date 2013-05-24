
# conf.d/10-auth.conf

default['dovecot']['conf']['disable_plaintext_auth'] = nil
default['dovecot']['conf']['auth_cache_size'] = nil
default['dovecot']['conf']['auth_cache_ttl'] = nil
default['dovecot']['conf']['auth_cache_negative_ttl'] = nil
default['dovecot']['conf']['auth_realms'] = nil
default['dovecot']['conf']['auth_default_realm'] = nil
default['dovecot']['conf']['auth_username_chars'] = nil
default['dovecot']['conf']['auth_username_translation'] = nil
default['dovecot']['conf']['auth_username_format'] = nil
default['dovecot']['conf']['auth_master_user_separator'] = nil
default['dovecot']['conf']['auth_anonymous_username'] = nil
default['dovecot']['conf']['auth_worker_max_count'] = nil
default['dovecot']['conf']['auth_gssapi_hostname'] = nil
default['dovecot']['conf']['auth_krb5_keytab'] = nil
default['dovecot']['conf']['auth_use_winbind'] = nil
default['dovecot']['conf']['auth_winbind_helper_path'] = nil
default['dovecot']['conf']['auth_failure_delay'] = nil
default['dovecot']['conf']['auth_ssl_require_client_cert'] = nil
default['dovecot']['conf']['auth_mechanisms'] = 'plain'

