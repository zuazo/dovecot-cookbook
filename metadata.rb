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
  :description => 'Username to use for users logging in with ANONYMOUS SASL mechanism.',
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

attribute 'dovecot/conf/auth_ssl_require_client_cert',
  :display_name => 'auth ssl require client cert',
  :description => 'Take the username from client\'s SSL certificate, using X509_NAME_get_text_by_NID() which returns the subject\'s DN\'s CommonName.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_mechanisms',
  :display_name => 'auth mechanisms',
  :description => 'Space separated list of wanted authentication mechanisms: plain, login, digest-md5, cram-md5, ntlm, rpa, apop, anonymous, gssapi, otp, skey, gss-spnego',
  :type => 'string',
  :required => 'optional',
  :default => 'plain'

#
# conf.d/10-director.conf
#

attribute 'dovecot/conf/director_servers',
  :display_name => 'director servers',
  :description => 'List of IPs or hostnames to all director servers, including ourself (as a string or as an array).',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/director_mail_servers',
  :display_name => 'director mail servers',
  :description => 'List of IPs or hostnames to all backend mail servers.',
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
  :description => 'TCP/IP port that accepts doveadm connections (instead of director connections).',
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
  :description => 'Syslog facility to use if you\'re logging to syslog.',
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
  :description => 'In case of password mismatches, log the attempted password.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_debug',
  :display_name => 'auth debug',
  :description => 'Even more verbose logging for debugging purposes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/auth_debug_passwords',
  :display_name => 'auth debug passwords',
  :description => 'In case of password mismatches, log the passwords and used scheme so the problem can be debugged.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/mail_debug',
  :display_name => 'mail debug',
  :description => 'Enable mail process debugging.',
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
  :description => 'Prefix for each line written to log file.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_log_format_elements',
  :display_name => 'login log format elements',
  :description => 'Space-separated list (or array) of elements we want to log.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/login_log_format',
  :display_name => 'login log format',
  :description => 'Login log format.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/mail_log_prefix',
  :display_name => 'mail log prefix',
  :description => 'Log prefix for mail processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/conf/deliver_log_format',
  :display_name => 'deliver log format',
  :description => 'Format to use for logging mail deliveries.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

#
# conf.d/10-mail.conf
#

attribute 'dovecot/mail_location',
  :display_name => 'mail location',
  :description => 'Location for user\'s mailboxes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_uid',
  :display_name => 'mail uid',
  :description => 'System user used to access mails.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_gid',
  :display_name => 'mail gid',
  :description => 'System group used to access mails.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_privileged_group',
  :display_name => 'mail privileged group',
  :description => 'Group to enable temporarily for privileged operations.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_access_groups',
  :display_name => 'mail access groups',
  :description => 'Grant access to these supplementary groups for mail processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_full_filesystem_access',
  :display_name => 'mail full filesystem access',
  :description => 'Allow full filesystem access to clients.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mmap_disable',
  :display_name => 'mmap disable',
  :description => 'Don\'t use mmap() at all.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/dotlock_use_excl',
  :display_name => 'dotlock use excl',
  :description => 'Rely on O_EXCL to work when creating dotlock files.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_fsync',
  :display_name => 'mail fsync',
  :description => 'When to use fsync() or fdatasync() calls: optimized, always or never',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_nfs_storage',
  :display_name => 'mail nfs storage',
  :description => 'Mail storage exists in NFS.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_nfs_index',
  :display_name => 'mail nfs index',
  :description => 'Mail index files also exist in NFS.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/lock_method',
  :display_name => 'lock method',
  :description => 'Locking method for index files: fcntl, flock or dotlock.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_temp_dir',
  :display_name => 'mail temp dir',
  :description => 'Directory in which LDA/LMTP temporarily stores incoming mails >128 kB.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/first_valid_uid',
  :display_name => 'first valid uid',
  :description => 'Valid UID range for users, defaults to 500 and above.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/last_valid_uid',
  :display_name => 'last valid uid',
  :description => 'Valid UID range for users, defaults to 500 and above.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/first_valid_gid',
  :display_name => 'first valid gid',
  :description => 'Valid GID range for users, defaults to non-root/wheel.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/last_valid_gid',
  :display_name => 'last valid gid',
  :description => 'Valid GID range for users, defaults to non-root/wheel.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_max_keyword_length',
  :display_name => 'mail max keyword length',
  :description => 'Maximum allowed length for mail keyword name.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/valid_chroot_dirs',
  :display_name => 'valid chroot dirs',
  :description => '\':\' separated list of directories under which chrooting is allowed for mail processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_chroot',
  :display_name => 'mail chroot',
  :description => 'Default chroot directory for mail processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/auth_socket_path',
  :display_name => 'auth socket path',
  :description => 'UNIX socket path to master authentication server to find users.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_plugin_dir',
  :display_name => 'mail plugin dir',
  :description => 'Directory where to look up mail plugins.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_cache_min_mail_count',
  :display_name => 'mail cache min mail count',
  :description => 'The minimum number of mails in a mailbox before updates are done to cache file.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mailbox_idle_check_interval',
  :display_name => 'mailbox idle check interval',
  :description => 'When IDLE command is running, mailbox is checked once in a while to see if there are any new mails or other changes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_save_crlf',
  :display_name => 'mail save crlf',
  :description => 'Save mails with CR+LF instead of plain LF.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/maildir_stat_dirs',
  :display_name => 'maildir stat dirs',
  :description => 'By default LIST command returns all entries in maildir beginning with a dot.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/maildir_copy_with_hardlinks',
  :display_name => 'maildir copy with hardlinks',
  :description => 'When copying a message, do it with hard links whenever possible.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/maildir_very_dirty_syncs',
  :display_name => 'maildir very dirty syncs',
  :description => 'Assume Dovecot is the only MUA accessing Maildir.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_read_locks',
  :display_name => 'mbox read locks',
  :description => 'Which read locking methods to use for locking mbox: dotlock, dotlock_try, fcntl, flock or lockfyy',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_write_locks',
  :display_name => 'mbox write locks',
  :description => 'Which write locking methods to use for locking mbox: dotlock, dotlock_try, fcntl, flock or lockfyy',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_lock_timeout',
  :display_name => 'mbox lock timeout',
  :description => 'Maximum time to wait for lock (all of them) before aborting.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_dotlock_change_timeout',
  :display_name => 'mbox dotlock change timeout',
  :description => 'If dotlock exists but the mailbox isn\'t modified in any way, override the lock file after this much time.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_dirty_syncs',
  :display_name => 'mbox dirty syncs',
  :description => 'When mbox changes unexpectedly simply read the new mails but still safely fallbacks to re-reading the whole mbox file whenever something in mbox isn\'t how it\'s expected to be.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_very_dirty_syncs',
  :display_name => 'mbox very dirty syncs',
  :description => 'Like mbox_dirty_syncs, but don\'t do full syncs even with SELECT, EXAMINE, EXPUNGE or CHECK commands.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_lazy_writes',
  :display_name => 'mbox lazy writes',
  :description => 'Delay writing mbox headers until doing a full write sync (EXPUNGE and CHECK commands and when closing the mailbox).',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mbox_min_index_size',
  :display_name => 'mbox min index size',
  :description => 'If mbox size is smaller than this (e.g. 100k), don\'t write index files.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mdbox_rotate_size',
  :display_name => 'mdbox rotate size',
  :description => 'Maximum dbox file size until it\'s rotated.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mdbox_rotate_interval',
  :display_name => 'mdbox rotate interval',
  :description => 'Maximum dbox file age until it\'s rotated.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mdbox_preallocate_space',
  :display_name => 'mdbox preallocate space',
  :description => 'When creating new mdbox files, immediately preallocate their size to mdbox_rotate_size.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_attachment_min_size',
  :display_name => 'mail attachment min size',
  :description => 'Attachments smaller than this aren\'t saved externally.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_attachment_fs',
  :display_name => 'mail attachment fs',
  :description => 'Filesystem backend to use for saving attachments: posix, sis posix or sis-queue posix.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/mail_attachment_hash',
  :display_name => 'mail attachment hash',
  :description => 'Hash format to use in attachment filenames.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

#
# conf.d/10-master.conf
#

attribute 'dovecot/default_process_limit',
  :display_name => 'default process limit',
  :description => 'Default process limit.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/default_client_limit',
  :display_name => 'default client limit',
  :description => 'Default client limit.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/default_vsz_limit',
  :display_name => 'default vsz limit',
  :description => 'Default VSZ (virtual memory size) limit for service processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/default_login_user',
  :display_name => 'default login user',
  :description => 'Login user is internally used by login processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/default_internal_user',
  :display_name => 'default internal user',
  :description => 'Internal user is used by unprivileged processes.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

#
# conf.d/10-ssl.conf
#

attribute 'dovecot/ssl',
  :display_name => 'ssl',
  :description => 'SSL/TLS support: true or false',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/ssl_cert',
  :display_name => 'ssl cert',
  :description => 'PEM encoded X.509 SSL/TLS certificate.',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'dovecot/ssl_key',
  :display_name => 'ssl key',
  :description => 'PEM encoded X.509 SSL/TLS private key.',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'dovecot/ssl_key_password',
  :display_name => 'ssl key password',
  :description => 'If key file is password protected, give the password here.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/ssl_ca',
  :display_name => 'ssl ca',
  :description => 'PEM encoded trusted certificate authority.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/ssl_verify_client_cert',
  :display_name => 'ssl verify client cert',
  :description => 'Request client to send a certificate.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/ssl_cert_username_field',
  :display_name => 'ssl cert username field',
  :description => 'Which field from certificate to use for username.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/ssl_parameters_regenerate',
  :display_name => 'ssl parameters regenerate',
  :description => 'How often to regenerate the SSL parameters file.',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

attribute 'dovecot/ssl_cipher_list',
  :display_name => 'ssl cipher list',
  :description => 'SSL ciphers to use',
  :type => 'string',
  :required => 'optional',
  :default => 'nil'

