name             'dovecot'
maintainer       'Onddo Labs, Sl.'
maintainer_email 'team@onddo.com'
license          'Apache 2.0'
description      'Installs and configures dovecot.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'centos', '>= 6.0'
supports 'debian', '>= 7.0'
supports 'ubuntu', '>= 12.04'

attribute 'dovecot/user',
  :display_name => 'dovecot user',
  :description => 'Dovector system user. Should no be changed.',
  :type => 'string',
  :required => 'optional',
  :default => 'dovecot'

attribute 'dovecot/group',
  :display_name => 'dovecot group',
  :description => 'Dovector system group. Should no be changed.',
  :type => 'string',
  :required => 'optional',
  :default => 'dovecot'

attribute 'dovecot/lib_path',
  :display_name => 'dovecot library path',
  :description => 'Dovector library path. Should no be changed.',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'dovecot/conf_path',
  :display_name => 'dovecot configuration path',
  :description => 'Dovector configruration files path. Should no be changed.',
  :type => 'string',
  :required => 'optional',
  :default => '/etc/dovecot'

attribute 'dovecot/conf_files_user',
  :display_name => 'dovecot configuration files user',
  :description => 'System user owner of configuration files.',
  :type => 'string',
  :required => 'optional',
  :default => 'root'

attribute 'dovecot/conf_files_group',
  :display_name => 'dovecot configuration files group',
  :description => 'System group owner of configuration files.',
  :type => 'string',
  :required => 'optional',
  :default => 'node["dovecot"]["group"]'

attribute 'dovecot/conf_files_mode',
  :display_name => 'dovecot configuration files mode',
  :description => 'Configuration files system file mode bits.',
  :type => 'string',
  :required => 'optional',
  :default => '00644'

attribute 'dovecot/conf_files/core',
  :display_name => 'dovecot core configuration files',
  :description => 'Dovecot core configuration files list.',
  :type => 'array',
  :required => 'optional',
  :default => [
    'conf.d/10-auth.conf',
    'conf.d/10-director.conf',
    'conf.d/10-logging.conf',
    'conf.d/10-mail.conf',
    'conf.d/10-master.conf',
    'conf.d/10-ssl.conf',
    'conf.d/10-tcpwrapper.conf',
    'conf.d/15-lda.conf',
    'conf.d/15-mailboxes.conf',
    'conf.d/90-acl.conf',
    'conf.d/90-plugin.conf',
    'conf.d/90-quota.conf',
    'conf.d/auth-checkpassword.conf.ext',
    'conf.d/auth-deny.conf.ext',
    'conf.d/auth-master.conf.ext',
    'conf.d/auth-passwdfile.conf.ext',
    'conf.d/auth-sql.conf.ext',
    'conf.d/auth-static.conf.ext',
    'conf.d/auth-system.conf.ext',
    'conf.d/auth-vpopmail.conf.ext',
    'dovecot.conf',
    'dovecot-db.conf.ext',
    'dovecot-dict-sql.conf.ext',
    'dovecot-sql.conf.ext',
  ]

attribute 'dovecot/conf_files/imap',
  :display_name => 'dovecot imap configuration files',
  :description => 'Dovecot IMAP configuration files list.',
  :type => 'array',
  :required => 'optional',
  :default => [
    'conf.d/20-imap.conf',
  ]

attribute 'dovecot/conf_files/pop3',
  :display_name => 'dovecot pop3 configuration files',
  :description => 'Dovecot POP3 configuration files list.',
  :type => 'array',
  :required => 'optional',
  :default => [
    'conf.d/20-pop3.conf',
  ]

attribute 'dovecot/conf_files/lmtp',
  :display_name => 'dovecot lmtp configuration files',
  :description => 'Dovecot LMTP configuration files list.',
  :type => 'array',
  :required => 'optional',
  :default => [
    'conf.d/20-lmtp.conf',
  ]

attribute 'dovecot/conf_files/sieve',
  :display_name => 'dovecot sieve configuration files',
  :description => 'Dovecot Sieve configuration files list.',
  :type => 'array',
  :required => 'optional',
  :default => [
    'conf.d/20-managesieve.conf',
    'conf.d/90-sieve.conf',
  ]

attribute 'dovecot/conf_files/ldap',
  :display_name => 'dovecot ldap configuration files',
  :description => 'Dovecot LDAP configuration files list.',
  :type => 'array',
  :required => 'optional',
  :default => [
    'dovecot-ldap.conf.ext',
    'conf.d/auth-ldap.conf.ext',
  ]

attribute 'dovecot/auth',
  :display_name => 'dovecot auth',
  :description => 'Dovecot Authentication Databases as a hash of hashes. Supported authdbs: checkpassword, deny, ldap, master, passwdfile, sql, system and vpopmail.',
  :type => 'string',
  :required => 'optional',
  :default => '{}'

attribute 'dovecot/namespaces',
  :display_name => 'dovecot namespaces',
  :description => 'Dovecot Namespaces as an array of hashes.',
  :type => 'array',
  :required => 'optional',
  :default => []

attribute 'dovecot/plugins',
  :display_name => 'dovecot plugins',
  :description => 'Dovecot Plugins configuration as a hash of hashes. Supported plugins: mail_log, acl and quota.',
  :type => 'string',
  :required => 'optional',
  :default => '{
    "sieve" => {
      "sieve" => "~/.dovecot.sieve",
      "sieve_dir" => "~/sieve",
    }
  }'

attribute 'dovecot/protocolos',
  :display_name => 'dovecot protocols',
  :description => 'Dovecot Protocols configuration as a hash of hashes. Supported protocols: lda, imap, lmtp, sieve and pop3.',
  :type => 'string',
  :required => 'optional',
  :default => '{}'

attribute 'dovecot/services',
  :display_name => 'dovecot services',
  :description => 'Dovecot Services configuration as a hash of hashes. Supported services: director, imap-login, pop3-login, lmtp, imap, pop3, auth, auth-worker, dict, tcpwrap, managesieve-login and managesieve.',
  :type => 'string',
  :required => 'optional',
  :default => '{}'

grouping 'dovecot/conf',
 :title => 'dovecot conf',
 :description => 'Dovecot configuration values'

attribute 'dovecot/conf/mail_plugins',
  :display_name => 'dovecot mail plugins',
  :description => 'Dovecot default enabled mail_plugins.',
  :type => 'array',
  :required => 'optional',
  :default => []

#
# dovecot.conf
#

attribute 'dovecot/conf/listen',
  :display_name => 'listen',
  :description => 'A comma separated list of IPs or hosts where to listen in for connections.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/base_dir',
  :display_name => 'dovecot base dir',
  :description => 'Base directory where to store runtime data.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/instance_name',
  :display_name => 'instance name',
  :description => 'Name of this instance. Used to prefix all Dovecot processes in ps output.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_greeting',
  :display_name => 'login greeting',
  :description => 'Greeting message for clients.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_trusted_networks',
  :display_name => 'login trusted networks',
  :description => 'Space separated list of trusted network ranges.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_access_sockets',
  :display_name => 'login access sockets',
  :description => 'Space separated list of login access check sockets.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/verbose_proctitle',
  :display_name => 'verbose proctitle',
  :description => 'Show more verbose process titles (in ps).',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/shutdown_clients',
  :display_name => 'shutdown clients',
  :description => 'Should all processes be killed when Dovecot master process shuts down.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/doveadm_worker_count',
  :display_name => 'doveadm worker count',
  :description => 'If non-zero, run mail commands via this many connections to doveadm server.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/doveadm_socket_path',
  :display_name => 'doveadm socket path',
  :description => 'UNIX socket or host:port used for connecting to doveadm server.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/import_environment',
  :display_name => 'import environment',
  :description => 'Space separated list of environment variables that are preserved on Dovecot startup and his childs.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/dict',
  :display_name => 'dict',
  :description => 'Dictionary server settings as a hash.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

#
# conf.d/10-auth.conf
#

attribute 'dovecot/conf/disable_plaintext_auth',
  :display_name => 'disable plaintext auth',
  :description => 'Disable LOGIN command and all other plaintext authentications unless SSL/TLS is used.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_cache_size',
  :display_name => 'auth cache size',
  :description => 'Authentication cache size (e.g. 10M). 0 means it\'s disabled.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_cache_ttl',
  :display_name => 'auth cache ttl',
  :description => 'Time to live for cached data.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_cache_negative_ttl',
  :display_name => 'auth cache negative ttl',
  :description => 'TTL for negative hits (user not found, password mismatch).',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_realms',
  :display_name => 'disable plaintext auth',
  :description => 'Space separated list (or array) of realms for SASL authentication mechanisms that need them.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_default_realm',
  :display_name => 'auth default realm',
  :description => 'Default realm/domain to use if none was specified.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_username_chars',
  :display_name => 'auth username chars',
  :description => 'List of allowed characters in username.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_username_translation',
  :display_name => 'auth username translation',
  :description => 'Username character translations before it\'s looked up from databases.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_username_format',
  :display_name => 'auth username format',
  :description => 'Username formatting before it\'s looked up from databases.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_master_user_separator',
  :display_name => 'auth master user separator',
  :description => 'If you want to allow master users to log in by specifying the master username within the normal username string, you can specify the separator character here (format: <username><separator><master username>).',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_anonymous_username',
  :display_name => 'auth anonymous username',
  :description => 'Username to use for users logging in with ANONYMOUS SASL mechanism',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_worker_max_count',
  :display_name => 'auth worker max count',
  :description => 'Maximum number of dovecot-auth worker processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_gssapi_hostname',
  :display_name => 'auth gssapi hostname',
  :description => 'Host name to use in GSSAPI principal names.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_krb5_keytab',
  :display_name => 'auth krb5 keytab',
  :description => 'Kerberos keytab to use for the GSSAPI mechanism.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_use_winbind',
  :display_name => 'auth use winbind',
  :description => 'Do NTLM and GSS-SPNEGO authentication using Samba\'s winbind daemon and ntlm_auth helper.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_winbind_helper_path',
  :display_name => 'auth winbind helper path',
  :description => 'Path for Samba\'s ntlm_auth helper binary.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_failure_delay',
  :display_name => 'auth failure delay',
  :description => 'Time to delay before replying to failed authentications.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

#
# conf.d/10-director.conf
#

attribute 'dovecot/conf/director_servers',
  :display_name => 'director servers',
  :description => 'List of IPs or hostnames to all director servers, including ourself (as a string or as an array). Ports can be specified as ip:port. The default port is the same as what director service\'s inet_listener is using.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/director_mail_servers',
  :display_name => 'director mail servers',
  :description => 'List of IPs or hostnames to all backend mail servers. Ranges are allowed too, like 10.0.0.10-10.0.0.30.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/director_user_expire',
  :display_name => 'director_user_expire',
  :description => 'How long to redirect users to a specific server after it no longer has any connections.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/director_doveadm_port',
  :display_name => 'director doveadm port',
  :description => 'TCP/IP port that accepts doveadm connections (instead of director connections). If you enable this, you\'ll also need to add inet_listener for the port.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

#
# conf.d/10-logging.conf
#

attribute 'dovecot/conf/log_path',
  :display_name => 'path',
  :description => 'Log file to use for error messages. "syslog" logs to syslog, /dev/stderr logs to stderr.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/info_log_path',
  :display_name => 'info log path',
  :description => 'Log file to use for informational messages. Defaults to log_path.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/debug_log_path',
  :display_name => 'debug log path',
  :description => 'Log file to use for debug messages. Defaults to info_log_path.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/syslog_facility',
  :display_name => 'syslog facility',
  :description => 'Syslog facility to use if you\'re logging to syslog. Usually if you don\'t want to use "mail", you\'ll use local0..local7. Also other standard facilities are supported.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_verbose',
  :display_name => 'auth verbose',
  :description => 'Log unsuccessful authentication attempts and the reasons why they failed.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_verbose_passwords',
  :display_name => 'auth verbose passwords',
  :description => 'In case of password mismatches, log the attempted password. Valid values are no, plain and sha1. sha1 can be useful for detecting brute force password attempts vs. user simply trying the same password over and over again.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_debug',
  :display_name => 'auth debug',
  :description => 'Even more verbose logging for debugging purposes. Shows for example SQL queries.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_debug_passwords',
  :display_name => 'auth debug passwords',
  :description => 'In case of password mismatches, log the passwords and used scheme so the problem can be debugged. Enabling this also enables auth_debug.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/mail_debug',
  :display_name => 'mail debug',
  :description => 'Enable mail process debugging. This can help you figure out why Dovecot isn\'t finding your mails.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/verbose_ssl',
  :display_name => 'verbose ssl',
  :description => 'Show protocol level SSL errors.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/log_timestamp',
  :display_name => 'log timestamp',
  :description => 'Prefix for each line written to log file. % codes are in strftime(3) format.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_log_format_elements',
  :display_name => 'login log format elements',
  :description => 'Space-separated list of elements we want to log. The elements which have a non-empty variable value are joined together to form a comma-separated string.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_log_format',
  :display_name => 'login log format',
  :description => 'Login log format. %$ contains login_log_format_elements string, %s contains the data we want to log.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/mail_log_prefix',
  :display_name => 'mail log prefix',
  :description => 'Log prefix for mail processes. See doc/wiki/Variables.txt for list of possible variables you can use.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/deliver_log_format',
  :display_name => 'deliver log format',
  :description => 'Format to use for logging mail deliveries. You can use variables: %$ - Delivery status message (e.g. "saved to INBOX"), %m - Message-ID, %s - Subject, %f - From address, %p - Physical size, %w - Virtual size',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

