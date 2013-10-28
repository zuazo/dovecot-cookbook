Description
===========

Installs and configures [Dovecot](http://www.dovecot.org/), open source IMAP and POP3 email server.

Requirements
============

## Platform:

This cookbook has been tested on the following platforms:

* CentOS >= 6.0
* Debian >= 7.0
* Ubuntu >= 12.04

Let me know if you use it successfully on any other platform.

## Applications:

* **Dovecot >= 2**: requires this version of dovecot to be available by the distribution's package manager.

Attributes
==========

To see a more complete description of the attributes, go to the [Dovecot wiki2 configuration section](http://wiki2.dovecot.org/#Dovecot_configuration) or read the comments in the templates and generated configuration files.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['user']</code></td>
    <td>Dovector system user. Should no be changed.</td>
    <td><code>"dovecot"</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['group']</code></td>
    <td>Dovector system group. Should no be changed.</td>
    <td><code>"dovecot"</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['lib_path']</code></td>
    <td>Dovector library path. Should no be changed.</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_path']</code></td>
    <td>Dovector configruration files path. Should no be changed.</td>
    <td><code>"/etc/dovecot"</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files_user']</code></td>
    <td>System user owner of configuration files.</td>
    <td><code>"root"</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files_group']</code></td>
    <td>System group owner of configuration files.</td>
    <td><code>node["dovecot"]["group"]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files_mode']</code></td>
    <td>Configuration files system file mode bits.</td>
    <td><code>00644</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files']['core']</code></td>
    <td>Dovecot core configuration files list.</td>
    <td><code>[<br/>
      &nbsp;&nbsp;"conf.d/10-auth.conf",<br/>
      &nbsp;&nbsp;"conf.d/10-director.conf",<br/>
      &nbsp;&nbsp;"conf.d/10-logging.conf",<br/>
      &nbsp;&nbsp;"conf.d/10-mail.conf",<br/>
      &nbsp;&nbsp;"conf.d/10-master.conf",<br/>
      &nbsp;&nbsp;"conf.d/10-ssl.conf",<br/>
      &nbsp;&nbsp;"conf.d/10-tcpwrapper.conf",<br/>
      &nbsp;&nbsp;"conf.d/15-lda.conf",<br/>
      &nbsp;&nbsp;"conf.d/15-mailboxes.conf",<br/>
      &nbsp;&nbsp;"conf.d/90-acl.conf",<br/>
      &nbsp;&nbsp;"conf.d/90-plugin.conf",<br/>
      &nbsp;&nbsp;"conf.d/90-quota.conf",<br/>
      &nbsp;&nbsp;"conf.d/auth-checkpassword.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-deny.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-master.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-passwdfile.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-sql.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-static.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-system.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-vpopmail.conf.ext",<br/>
      &nbsp;&nbsp;"dovecot.conf",<br/>
      &nbsp;&nbsp;"dovecot-db.conf.ext",<br/>
      &nbsp;&nbsp;"dovecot-dict-sql.conf.ext",<br/>
      &nbsp;&nbsp;"dovecot-sql.conf.ext"<br/>
    ]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files']['imap']</code></td>
    <td>Dovecot IMAP configuration files list.</td>
    <td><code>["conf.d/20-imap.conf"]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files']['pop3']</code></td>
    <td>Dovecot POP3 configuration files list.</td>
    <td><code>["conf.d/20-pop3.conf"]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files']['lmtp']</code></td>
    <td>Dovecot LMTP configuration files list.</td>
    <td><code>["conf.d/20-lmtp.conf"]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files']['sieve']</code></td>
    <td>Dovecot Sieve configuration files list.</td>
    <td><code>[<br/>
      &nbsp;&nbsp;"conf.d/20-managesieve.conf",<br/>
      &nbsp;&nbsp;"conf.d/90-sieve.conf"<br/>
    ]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf_files']['ldap']</code></td>
    <td>Dovecot LDAP configuration files list.</td>
    <td><code>[<br/>
      &nbsp;&nbsp;"dovecot-ldap.conf.ext",<br/>
      &nbsp;&nbsp;"conf.d/auth-ldap.conf.ext"<br/>
    ]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['auth']</code></td>
    <td>Dovecot Authentication Databases as a hash of hashes (<a href="#authentication-database-examples">see the examples below</a>). Supported authdbs: checkpassword, deny, ldap, master, passwdfile, sql, system and vpopmail.</td>
    <td><code>{}</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['namespaces']</code></td>
    <td>Dovecot Namespaces as an array of hashes (<a href="#namespaces-example">see the example below</a>).</td>
    <td><code>[]</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['plugins']</code></td>
    <td>Dovecot Plugins configuration as a hash of hashes (<a href="#plugins-examples">see the examples below</a>). Supported plugins: mail_log, acl and quota.</td>
    <td><code>{<br/>
      &nbsp;&nbsp;"sieve" => {<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;"sieve" => "~/.dovecot.sieve",<br/>
      &nbsp;&nbsp;&nbsp;&nbsp;"sieve_dir" => "~/sieve",<br/>
      &nbsp;&nbsp;}<br/>
    }</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['protocols']</code></td>
    <td>Dovecot Protocols configuration as a hash of hashes (<a href="#protocols-example">see the example below</a>). Supported protocols: lda, imap, lmtp, sieve and pop3.</td>
    <td><code>{}</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['services']</code></td>
    <td>Dovecot Services configuration as a hash of hashes (<a href="#service-examples">see the examples below</a>). Supported services: director, imap-login, pop3-login, lmtp, imap, pop3, auth, auth-worker, dict, tcpwrap, managesieve-login and managesieve.</td>
    <td><code>{}</code></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_plugins']</code></td>
    <td>Dovecot default enabled mail_plugins.</td>
    <td><code>[]</code></td>
  </tr>
</table>

## Main configuration attributes

* Configuration file: `dovecot.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['listen']</code></td>
    <td>A comma separated list of IPs or hosts where to listen in for connections.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['base_dir']</code></td>
    <td>Base directory where to store runtime data.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['instance_name']</code></td>
    <td>Name of this instance. Used to prefix all Dovecot processes in ps output.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['login_greeting']</code></td>
    <td>Greeting message for clients.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['login_trusted_networks']</code></td>
    <td>Space separated list of trusted network ranges.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['login_access_sockets']</code></td>
    <td>Space separated list of login access check sockets.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['verbose_proctitle']</code></td>
    <td>Show more verbose process titles (in ps).</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['shutdown_clients']</code></td>
    <td>Should all processes be killed when Dovecot master process shuts down.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['doveadm_worker_count']</code></td>
    <td>If non-zero, run mail commands via this many connections to doveadm server.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['doveadm_socket_path']</code></td>
    <td>UNIX socket or host:port used for connecting to doveadm server.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['import_environment']</code></td>
    <td>Space separated list of environment variables that are preserved on Dovecot startup and his childs.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['dict']</code></td>
    <td>Dictionary server settings as a hash.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## Authentication processes attributes

* Configuration file: `conf.d/10-auth.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['disable_plaintext_auth']</code></td>
    <td>Disable LOGIN command and all other plaintext authentications unless SSL/TLS is used.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_cache_size']</code></td>
    <td>Authentication cache size (e.g. 10M). 0 means it's disabled.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_cache_ttl']</code></td>
    <td>Time to live for cached data.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_cache_negative_ttl']</code></td>
    <td>TTL for negative hits (user not found, password mismatch).</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_realms']</code></td>
    <td>Space separated list (or array) of realms for SASL authentication mechanisms that need them.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_default_realm']</code></td>
    <td>Default realm/domain to use if none was specified.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_username_chars']</code></td>
    <td>List of allowed characters in username.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_username_translation']</code></td>
    <td>Username character translations before it's looked up from databases.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_username_format']</code></td>
    <td>Username formatting before it's looked up from databases.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_master_user_separator']</code></td>
    <td>If you want to allow master users to log in by specifying the master username within the normal username string, you can specify the separator character here (format: <username><separator><master username>).</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_anonymous_username']</code></td>
    <td>Username to use for users logging in with ANONYMOUS SASL mechanism.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_worker_max_count']</code></td>
    <td>Maximum number of dovecot-auth worker processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_gssapi_hostname']</code></td>
    <td>Host name to use in GSSAPI principal names.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_krb5_keytab']</code></td>
    <td>Kerberos keytab to use for the GSSAPI mechanism.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_use_winbind']</code></td>
    <td>Do NTLM and GSS-SPNEGO authentication using Samba's winbind daemon and ntlm_auth helper.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_winbind_helper_path']</code></td>
    <td>Path for Samba's ntlm_auth helper binary.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_failure_delay']</code></td>
    <td>Time to delay before replying to failed authentications.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_ssl_require_client_cert']</code></td>
    <td>Take the username from client's SSL certificate, using X509_NAME_get_text_by_NID() which returns the subject's DN's CommonName.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_mechanisms']</code></td>
    <td>Space separated list of wanted authentication mechanisms: plain, login, digest-md5, cram-md5, ntlm, rpa, apop, anonymous, gssapi, otp, skey, gss-spnego</td>
    <td><code>"plain"</code></td>
  </tr>
</table>

## Director-specific attributes

* Configuration file: `conf.d/10-director.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['director_servers']</code></td>
    <td>List of IPs or hostnames to all director servers, including ourself (as a string or as an array).</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['director_mail_servers']</code></td>
    <td>List of IPs or hostnames to all backend mail servers.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['director_user_expire']</code></td>
    <td>How long to redirect users to a specific server after it no longer has any connections.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['director_doveadm_port']</code></td>
    <td>TCP/IP port that accepts doveadm connections (instead of director connections).</td>
    <td><em>nil</em></td>
  </tr>
</table>

## Log destination attributes

* Configuration file: `conf.d/10-logging.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['log_path']</code></td>
    <td>Log file to use for error messages. "syslog" logs to syslog, /dev/stderr logs to stderr.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['info_log_path']</code></td>
    <td>Log file to use for informational messages. Defaults to log_path.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['debug_log_path']</code></td>
    <td>Log file to use for debug messages. Defaults to info_log_path.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['syslog_facility']</code></td>
    <td>Syslog facility to use if you're logging to syslog.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_verbose']</code></td>
    <td>Log unsuccessful authentication attempts and the reasons why they failed.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_verbose_passwords']</code></td>
    <td>In case of password mismatches, log the attempted password.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_debug']</code></td>
    <td>Even more verbose logging for debugging purposes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_debug_passwords']</code></td>
    <td>In case of password mismatches, log the passwords and used scheme so the problem can be debugged.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_debug']</code></td>
    <td>Enable mail process debugging.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['verbose_ssl']</code></td>
    <td>Show protocol level SSL errors.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['log_timestamp']</code></td>
    <td>Prefix for each line written to log file.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['login_log_format_elements']</code></td>
    <td>Space-separated list (or array) of elements we want to log.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['login_log_format']</code></td>
    <td>Login log format.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_log_prefix']</code></td>
    <td>Log prefix for mail processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['deliver_log_format']</code></td>
    <td>Format to use for logging mail deliveries.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## Mailbox locations and namespaces attributes

* Configuration file: `conf.d/10-mail.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_location']</code></td>
    <td>Location for user's mailboxes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_uid']</code></td>
    <td>System user used to access mails.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_gid']</code></td>
    <td>System group used to access mails.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_privileged_group']</code></td>
    <td>Group to enable temporarily for privileged operations.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_access_groups']</code></td>
    <td>Grant access to these supplementary groups for mail processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_full_filesystem_access']</code></td>
    <td>Allow full filesystem access to clients.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mmap_disable']</code></td>
    <td>Don't use mmap() at all.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['dotlock_use_excl']</code></td>
    <td>Rely on O_EXCL to work when creating dotlock files.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_fsync']</code></td>
    <td>When to use fsync() or fdatasync() calls: optimized, always or never</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_nfs_storage']</code></td>
    <td>Mail storage exists in NFS.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_nfs_index']</code></td>
    <td>Mail index files also exist in NFS.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['lock_method']</code></td>
    <td>Locking method for index files: fcntl, flock or dotlock.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_temp_dir']</code></td>
    <td>Directory in which LDA/LMTP temporarily stores incoming mails >128 kB.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['first_valid_uid']</code></td>
    <td>Valid UID range for users, defaults to 500 and above.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['last_valid_uid']</code></td>
    <td>Valid UID range for users, defaults to 500 and above.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['first_valid_gid']</code></td>
    <td>Valid GID range for users, defaults to non-root/wheel.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['last_valid_gid']</code></td>
    <td>Valid GID range for users, defaults to non-root/wheel.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_max_keyword_length']</code></td>
    <td>Maximum allowed length for mail keyword name.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['valid_chroot_dirs']</code></td>
    <td>':' separated list of directories under which chrooting is allowed for mail processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_chroot']</code></td>
    <td>Default chroot directory for mail processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['auth_socket_path']</code></td>
    <td>UNIX socket path to master authentication server to find users.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_plugin_dir']</code></td>
    <td>Directory where to look up mail plugins.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_cache_min_mail_count']</code></td>
    <td>The minimum number of mails in a mailbox before updates are done to cache file.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mailbox_idle_check_interval']</code></td>
    <td>When IDLE command is running, mailbox is checked once in a while to see if there are any new mails or other changes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_save_crlf']</code></td>
    <td>Save mails with CR+LF instead of plain LF.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['maildir_stat_dirs']</code></td>
    <td>By default LIST command returns all entries in maildir beginning with a dot.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['maildir_copy_with_hardlinks']</code></td>
    <td>When copying a message, do it with hard links whenever possible.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['maildir_very_dirty_syncs']</code></td>
    <td>Assume Dovecot is the only MUA accessing Maildir.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_read_locks']</code></td>
    <td>Which read locking methods to use for locking mbox: dotlock, dotlock_try, fcntl, flock or lockfyy</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_write_locks']</code></td>
    <td>Which write locking methods to use for locking mbox: dotlock, dotlock_try, fcntl, flock or lockfyy</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_lock_timeout']</code></td>
    <td>Maximum time to wait for lock (all of them) before aborting.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_dotlock_change_timeout']</code></td>
    <td>If dotlock exists but the mailbox isn't modified in any way, override the lock file after this much time.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_dirty_syncs']</code></td>
    <td>When mbox changes unexpectedly simply read the new mails but still safely fallbacks to re-reading the whole mbox file whenever something in mbox isn't how it's expected to be.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_very_dirty_syncs']</code></td>
    <td>Like mbox_dirty_syncs, but don't do full syncs even with SELECT, EXAMINE, EXPUNGE or CHECK commands.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_lazy_writes']</code></td>
    <td>Delay writing mbox headers until doing a full write sync (EXPUNGE and CHECK commands and when closing the mailbox).</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mbox_min_index_size']</code></td>
    <td>If mbox size is smaller than this (e.g. 100k), don't write index files.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mdbox_rotate_size']</code></td>
    <td>Maximum dbox file size until it's rotated.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mdbox_rotate_interval']</code></td>
    <td>Maximum dbox file age until it's rotated.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mdbox_preallocate_space']</code></td>
    <td>When creating new mdbox files, immediately preallocate their size to mdbox_rotate_size.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_attachment_min_size']</code></td>
    <td>Attachments smaller than this aren't saved externally.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_attachment_fs']</code></td>
    <td>Filesystem backend to use for saving attachments: posix, sis posix or sis-queue posix.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['mail_attachment_hash']</code></td>
    <td>Hash format to use in attachment filenames.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## Master configuration file attributes

* Configuration file: `conf.d/10-master.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['default_process_limit']</code></td>
    <td>Default process limit.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['default_client_limit']</code></td>
    <td>Default client limit.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['default_vsz_limit']</code></td>
    <td>Default VSZ (virtual memory size) limit for service processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['default_login_user']</code></td>
    <td>Login user is internally used by login processes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['default_internal_user']</code></td>
    <td>Internal user is used by unprivileged processes.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## SSL attributes

* Configuration file: `conf.d/10-ssl.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl']</code></td>
    <td>SSL/TLS support: true or false</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_cert']</code></td>
    <td>PEM encoded X.509 SSL/TLS certificate.</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_key']</code></td>
    <td>PEM encoded X.509 SSL/TLS private key.</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_key_password']</code></td>
    <td>If key file is password protected, give the password here.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_ca']</code></td>
    <td>PEM encoded trusted certificate authority.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_verify_client_cert']</code></td>
    <td>Request client to send a certificate.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_cert_username_field']</code></td>
    <td>Which field from certificate to use for username.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_parameters_regenerate']</code></td>
    <td>How often to regenerate the SSL parameters file.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ssl_cipher_list']</code></td>
    <td>SSL ciphers to use</td>
    <td><em>nil</em></td>
  </tr>
</table>

## LDA specific attributes

Also used by LMTP.

* Configuration files: `conf.d/15-lda.conf`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['postmaster_address']</code></td>
    <td>Address to use when sending rejection mails.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['hostname']</code></td>
    <td>Hostname to use in various parts of sent mails, eg. in Message-Id.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['quota_full_tempfail']</code></td>
    <td>If user is over quota, return with temporary failure instead of bouncing the mail.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sendmail_path']</code></td>
    <td>Binary to use for sending mails.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['submission_host']</code></td>
    <td>If non-empty, send mails via this SMTP host[:port] instead of sendmail.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['rejection_subject']</code></td>
    <td>Subject: header to use for rejection mails.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['rejection_reason']</code></td>
    <td>Human readable error message for rejection mails.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['recipient_delimiter']</code></td>
    <td>Delimiter character between local-part and detail in email address.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['lda_original_recipient_header']</code></td>
    <td>Header where the original recipient address (SMTP's RCPT TO: address) is taken from if not available elsewhere.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['lda_mailbox_autocreate']</code></td>
    <td>Should saving a mail to a nonexistent mailbox automatically create it?</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['lda_mailbox_autosubscribe']</code></td>
    <td>Should automatically created mailboxes be also automatically subscribed?</td>
    <td><em>nil</em></td>
  </tr>
</table>

## LMTP specific attributes

* Configuration file: `conf.d/20-lmtp.conf`

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['lmtp_proxy']</code></td>
    <td>Support proxying to other LMTP/SMTP servers by performing passdb lookups.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['lmtp_save_to_detail_mailbox']</code></td>
    <td>When recipient address includes the detail (e.g. user+detail), try to save the mail to the detail mailbox.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## Berkeley DB DB_CONFIG attributes

* Configuration file: `dovecot-db.conf.ext`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['db']</code></td>
    <td>DB_CONFIG for Berkeley DB as a hash.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## Dictionary quota SQL attributes

* Configuration files: `dovecot-dict-sql.conf.ext`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['dict_sql']['connect']</code></td>
    <td>Dict sql connect configuration as a string or an array.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['dict_sql']['maps']</code></td>
    <td>Dict sql database tables maps (<a href="#dictionary-quota-sql-example">see the example below</a>).</td>
    <td><em>nil</em></td>
  </tr>
</table>

## LDAP authentication attributes

* Condiguration files: `dovecot-ldap.conf.ext`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['hosts']</code></td>
    <td>Space separated list or array of LDAP hosts to use.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['uris']</code></td>
    <td>LDAP URIs to use.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['dn']</code></td>
    <td>Distinguished Name, the username used to login to the LDAP server.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['dnpass']</code></td>
    <td>Password for LDAP server, if dn is specified.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['sasl_bind']</code></td>
    <td>Use SASL binding instead of the simple binding.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['sasl_mech']</code></td>
    <td>SASL mechanism name to use.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['sasl_realm']</code></td>
    <td>SASL realm to use.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['sasl_authz_id']</code></td>
    <td>SASL authorization ID, ie. the dnpass is for this "master user", but the dn is still the logged in user.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls']</code></td>
    <td>Use TLS to connect to the LDAP server.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls_ca_cert_file']</code></td>
    <td>TLS options, currently supported only with OpenLDAP.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls_ca_cert_dir']</code></td>
    <td>TLS options, currently supported only with OpenLDAP.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls_cipher_suite']</code></td>
    <td>TLS options, currently supported only with OpenLDAP.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls_cert_file']</code></td>
    <td>TLS cert/key is used only if LDAP server requires a client certificate.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls_key_file']</code></td>
    <td>TLS cert/key is used only if LDAP server requires a client certificate.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['tls_require_cert']</code></td>
    <td>Valid values: never, hard, demand, allow, try</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['ldaprc_path']</code></td>
    <td>Use the given ldaprc path.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['debug_level']</code></td>
    <td>LDAP library debug level as specified by LDAP_DEBUG_* in ldap_log.h.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['auth_bind']</code></td>
    <td>Use authentication binding for verifying password's validity.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['auth_bind_userdn']</code></td>
    <td>If authentication binding is used, you can save one LDAP request per login if user's DN can be specified with a common template.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['ldap_version']</code></td>
    <td>LDAP protocol version to use. Likely 2 or 3.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['base']</code></td>
    <td>LDAP base. %variables can be used here.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['deref']</code></td>
    <td>Dereference: never, searching, finding or always.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['scope']</code></td>
    <td>Search scope: base, onelevel or subtree.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['user_attrs']</code></td>
    <td>User attributes are given in LDAP-name=dovecot-internal-name list.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['user_filter']</code></td>
    <td>Filter for user lookup.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['pass_attrs']</code></td>
    <td>Password checking attributes.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['pass_filter']</code></td>
    <td>Filter for password lookups.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['iterate_attrs']</code></td>
    <td>Attributes to get a list of all users</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['iterate_filter']</code></td>
    <td>Filter to get a list of all users</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['ldap']['default_pass_scheme']</code></td>
    <td>Default password scheme. "{scheme}" before password overrides this.</td>
    <td><em>nil</em></td>
  </tr>
</table>

## SQL authentication attributes

* Configuration file: `dovecot-sql.conf.ext`.

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sql']['driver']</code></td>
    <td>Database driver: mysql, pgsql or sqlite.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sql']['connect']</code></td>
    <td>Database connection string or array. This is driver-specific setting.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sql']['default_pass_scheme']</code></td>
    <td>Default password scheme.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sql']['password_query']</code></td>
    <td>passdb query to retrieve the password.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sql']['user_query']</code></td>
    <td>userdb query to retrieve the user information.</td>
    <td><em>nil</em></td>
  </tr>
  <tr>
    <td><code>node['dovecot']['conf']['sql']['iterate_query']</code></td>
    <td>Query to get a list of all usernames.</td>
    <td><em>nil</em></td>
  </tr>
</table>

Recipes
=======

## dovecot::default

Installs and configures Dovecot.

## dovecot::user

Creates the dovecot system user. Used by the default recipe.

## dovecot::conf_files

Generates all the configuration files. Used by the default recipe.

## dovecot::packages

Installs the required packages. Used by the default recipe.

## dovecot::service

Configures the Dovecot service. Used by the default recipe.

Usage Examples
==============

## Including in a Cookbook Recipe

You can simply include it in a recipe:

```ruby
# from a recipe
include_recipe 'dovecot'
```

Don't forget to include the `dovecot` cookbook as a dependency in the metadata.

```ruby
# metadata.rb
[...]

depends 'dovecot'
```

## Including in the Run List

Another alternative is to include the default recipe in your Run List.

```json
{
  "name": "mail.onddo.com",
  [...]
  "run_list": [
    [...]
    "recipe[dovecot]"
  ]
}
```

## Authentication Database Examples

Authentication database attributes, inside passdb or usedb hash values, can contain both arrays or hashes.

Supported auths are the following: `checkpassword`, `deny`, `ldap`, `master`, `passwdfile`, `sql`, `system` and `vpopmail`.

```ruby
node.default['dovecot']['auth']['checkpassword'] = {
  'passdb' => { # hash
    'driver' => 'checkpassword',
    'args' => '/usr/bin/checkpassword',
  },
  'userdb' => {
    'driver' => 'prefetch',
  },
}
```

```ruby
node.default['dovecot']['auth']['system']['passdb'] = [ # array
  {
    # without driver
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
```

## Dictionary Quota SQL Example

```ruby
node.default['dovecot']['conf']['dict_sql']['maps'] = [
  {
    'pattern' => 'priv/quota/storage',
    'table' => 'quota',
    'username_field' => 'username',
    'value_field' => 'bytes',
  },
  {
    'pattern' => 'priv/quota/messages',
    'table' => 'quota',
    'username_field' => 'username',
    'value_field' => 'messages',
  },
  {
    'pattern' => 'shared/expire/$user/$mailbox',
    'table' => 'expires',
    'value_field' => 'expire_stamp',
    'fields' => {
      'username' => '$user',
      'mailbox' => '$mailbox',
    },
  },
]
```

## Namespaces Example

The `['namespaces']` attribute is an array, which could conaint both array or hash values.

```ruby
node.default['dovecot']['namespaces'] = [
  {
    'separator' => '/',
    'prefix' => '"#mbox/"',
    'location' => 'mbox:~/mail:INBOX=/var/mail/%u',
    'inbox' => true,
    'hidden' => true,
    'list' => false,
  }, {
    'separator' => '/',
    'prefix' => '',
    'location' => 'maildir:~/Maildir',
  }, { # this requires Dovecot >= 2.1
    'name' => 'inbox',
    'separator' => '/',
    'prefix' => '',
    'inbox' => true,
    'mailboxes' => {
      'Drafts' => {
        'special_use' => '\Drafts',
      },
      'Junk' => {
        'special_use' => '\Junk',
      },
      'Trash' => {
        'special_use' => '\Trash',
      },
      'Sent' => {
        'special_use' => '\Sent',
      },
      'Sent Messages' => {
        'special_use' => '\Sent',
      },
      'virtual/All' => {
        'special_use' => '\All',
      },
      'virtual/Flagged' => {
        'special_use' => '\All',
      },
    },
  },
]
```

## Plugins Examples

Plugin attribute values should be of type hash.

Supported plugins are the following: `mail_log`, `acl` and `quota`.

### Mail Log Plugin Example

```ruby
node.default['dovecot']['plugins']['mail_log'] = {
  'mail_log_events' => 'delete undelete expunge copy mailbox_delete mailbox_rename',
  'mail_log_fields' => 'uid box msgid size'
}
```

### Sieve Plugin Example

```ruby
node.default['dovecot']['plugins']['sieve'] = {
  'sieve' => '~/.dovecot.sieve',
  'sieve_dir' => '~/sieve',
}
```

## Protocols Example

Protocol attribute values should be of type hash.

Supported protocols are the following: `lda`, `imap`, `lmtp`, `sieve` and `pop3`.

```ruby
node.default['dovecot']['protocols']['lda'] = {
  'mail_plugins' => [ '$mail_plugins' ],
}
```

## Service Examples

The `['services']` attribute is a hash. Each service attribute should be a hash. But the `['listeners']` subkey could contain both a hash and an array.

Inside this `listeners` key, you should name each listener with the format *PROTOCOL:NAME*. Allowed protocols are `fifo`, `unix` and `inet`.

Supported services are the following: `director`, `imap-login`, `pop3-login`, `lmtp`, `imap`, `pop3`, `auth`, `auth-worker`, `dict`, `tcpwrap`, `managesieve-login` and `managesieve`.

### Director Service Example

```ruby
node.default['dovecot']['services']['director']['listeners'] = [
  { 'unix:login/director' => {
      'mode' => '0666',
  } },
  { 'fifo:login/proxy-notify' => {
      'mode' => '0666',
  } },
  { 'unix:director-userdb' => {
      'mode' => '0666',
   } },
  { 'inet' => {
      'port' => '5432',
  } },
]
```

### Imap-login Service Example

```ruby
node.default['dovecot']['services']['imap-login'] = {
  'listeners' => [
    { 'inet:imap' => {
     'port' => 143,
    } },
    { 'inet:imaps' => {
      'port' => 993,
      'ssl' => true,
    } },
  ],
  'service_count' => 1,
  'process_min_avail' => 0,
  'vsz_limit' => '64M',
}
```

## Complete Example

This is a complete recipe example for installing and configuring Dovecot 2 to work with PostfixAdmin MySQL tables, including IMAP service:

```ruby

node.default['dovecot']['conf_files_group'] = 'vmail'

node.default['dovecot']['conf']['disable_plaintext_auth'] = false
node.default['dovecot']['conf_files_mode'] = '00640'

# 10-logging.conf
node.default['dovecot']['conf']['log_path'] = 'syslog'
node.default['dovecot']['conf']['syslog_facility'] = 'mail'
node.default['dovecot']['conf']['log_timestamp'] = '"%Y-%m-%d %H:%M:%S"'

# 10-mail.conf
node.default['dovecot']['conf']['mail_location'] = 'maildir:~/Maildir'
node.default['dovecot']['conf']['mail_privileged_group'] = 'mail'

# 10-master.conf
node.default['dovecot']['services']['auth']['listeners'] = [
  # auth_socket_path points to this userdb socket by default. It's typically
  # used by dovecot-lda, doveadm, possibly imap process, etc. Its default
  # permissions make it readable only by root, but you may need to relax these
  # permissions. Users that have access to this socket are able to get a list
  # of all usernames and get results of everyone's userdb lookups.
  { 'unix:auth-userdb' => {
    'mode' => '0600',
    'user' => 'vmail',
    'group' => 'vmail',
  } },
  # Postfix smtp-auth
  { 'unix:/var/spool/postfix/private/auth' => {
    'mode' => '0666',
    'user' => 'postfix',
    'group' => 'postfix',
  } },
]

# 15-lda.conf
node.default['dovecot']['conf']['postmaster_address'] = 'postmaster@mycompany.org' # TODO: Change this to fit your server
node.default['dovecot']['conf']['hostname'] = 'mail.mycompany.org' # TODO: Change this to fit your server
node.default['dovecot']['conf']['lda_mailbox_autocreate'] = true
node.default['dovecot']['conf']['lda_mailbox_autosubscribe'] = true
# We want sieve enabled
node.default['dovecot']['protocols']['lda']['mail_plugins'] = [ '$mail_plugins', 'sieve' ]

# 20-imap.conf
# We want IMAP enabled with the default configuration
node.default['dovecot']['protocols']['imap'] = {}

# 90-sieve.conf
node.default['dovecot']['plugins']['sieve']['sieve'] = '~/.dovecot.sieve'
node.default['dovecot']['plugins']['sieve']['sieve_dir'] = '~/sieve'
node.default['dovecot']['plugins']['sieve']['sieve_global_path'] = "#{node['dovecot']['conf_path']}/sieve/default.sieve"

# auth-sql.conf.ext
node.default['dovecot']['auth']['sql']['passdb']['args'] = '/etc/dovecot/dovecot-sql.conf.ext'
node.default['dovecot']['auth']['sql']['userdb']['args'] = '/etc/dovecot/dovecot-sql.conf.ext'

# auth-static.conf.ext
node.default['dovecot']['auth']['static']['userdb']['args'] = [
  'uid=vmail',
  'gid=vmail',
  'home=/var/vmail/%d/%n',
  'allow_all_users=yes',
]

# auth-system.conf.ext
node.default['dovecot']['auth']['system'] = {}

# dovecot-sql.conf.ext
# We want to enable MySQL driver
node.default['dovecot']['conf']['sql']['driver'] = 'mysql'
node.default['dovecot']['conf']['sql']['connect'] = [
  'host=localhost',
  'dbname=postfix',
  'user=postfix',
  'password=postfix_pass', # TODO: change this, please
]
# md5crypt encryption method
node.default['dovecot']['conf']['sql']['default_pass_scheme'] = 'MD5-CRYPT'
node.default['dovecot']['conf']['sql']['password_query'] = [
  'SELECT username AS user, password',
  'FROM mailbox',
  "WHERE username = '%u' AND active = '1'",
]
node.default['dovecot']['conf']['sql']['user_query'] = [
  'SELECT',
    'username AS user,',
    'password,',
    '5000 as uid,',
    '5000 as gid,',
    "concat('/var/vmail/', maildir) AS home,",
    "concat('maildir:/var/vmail/', maildir) AS mail",
  'FROM mailbox',
  "WHERE username = '%u' AND active = '1'",
]

node.default['dovecot']['conf']['sql']['iterate_query'] = [
  'SELECT username AS user',
  "FROM mailbox WHERE active = '1'",
]

include_recipe 'dovecot'

# Compile sieve scripts

# this should go after installing dovecot, sievec is required
execute 'sievec sieve_global_path' do
  command "sievec '#{node['dovecot']['conf_path']}/sieve/default.sieve'"
  action :nothing
end
directory ::File.dirname("#{node['dovecot']['conf_path']}/sieve/default.sieve") do
  owner 'root'
  group 'root'
  mode '00755'
  recursive true
  not_if do ::File.exists?(::File.dirname("#{node['dovecot']['conf_path']}/sieve/default.sieve")) end
end
# This will be the default sieve script:
template node['dovecot']['plugins']['sieve']['sieve_global_path'] do
  source 'default.sieve.erb'
  owner 'root'
  group 'root'
  mode '00644'
  notifies :run, 'execute[sievec sieve_global_path]'
end
```

If you want a more complete example, you can look at the [postfix-dovecot](https://github.com/onddo/postfix-dovecot-cookbook) recipe.

Testing
=======

## Requirements

* `vagrant`
* `berkshelf` >= `1.4.0`
* `test-kitchen` >= `1.0.0.alpha`
* `kitchen-vagrant` >= `0.10.0`

## Running the tests

```bash
$ kitchen test
$ kitchen verify
[...]
```

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Contributors
============

* [Andreas Lappe](https://github.com/alappe)
* [Trond Arve Nordheim](https://github.com/tanordheim)
* [Johan Svensson](https://github.com/loxley)


License and Author
=====================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Xabier de Zuazo (<xabier@onddo.com>)
| **Copyright:**       | Copyright (c) 2013 Onddo Labs, SL. (www.onddo.com)
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

