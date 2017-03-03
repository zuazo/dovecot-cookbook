Dovecot Cookbook
================
[![Cookbook Version](https://img.shields.io/cookbook/v/dovecot.svg?style=flat)](https://supermarket.chef.io/cookbooks/dovecot)
[![GitHub](http://img.shields.io/badge/github-zuazo/dovecot--cookbook-blue.svg?style=flat)](https://github.com/zuazo/dovecot-cookbook)
[![License](https://img.shields.io/github/license/zuazo/dovecot-cookbook.svg?style=flat)](#license-and-author)

[![Dependency Status](http://img.shields.io/gemnasium/zuazo/dovecot-cookbook.svg?style=flat)](https://gemnasium.com/zuazo/dovecot-cookbook)
[![Code Climate](http://img.shields.io/codeclimate/github/zuazo/dovecot-cookbook.svg?style=flat)](https://codeclimate.com/github/zuazo/dovecot-cookbook)
[![Build Status](http://img.shields.io/travis/zuazo/dovecot-cookbook.svg?style=flat)](https://travis-ci.org/zuazo/dovecot-cookbook)

[Chef](https://www.chef.io/) cookbook to install and configure [Dovecot](http://www.dovecot.org/), open source IMAP and POP3 email server.

Table of Contents
=================

* [Description](#description)
* [Requirements](#requirements)
  * [Supported Platforms](#supported-platforms)
  * [Required Cookbooks](#required-cookbooks)
  * [Required Applications](#required-applications)
* [Attributes](#attributes)
  * [Main Configuration Attributes](#main-configuration-attributes)
  * [Authentication Processes Attributes](#authentication-processes-attributes)
  * [Director-specific Attributes](#director-specific-attributes)
  * [Log Destination Attributes](#log-destination-attributes)
  * [Mailbox Locations and Namespaces Attributes](#mailbox-locations-and-namespaces-attributes)
  * [Master Configuration File Attributes](#master-configuration-file-attributes)
  * [SSL Attributes](#ssl-attributes)
  * [LDA Specific Attributes](#lda-specific-attributes)
  * [Replication Specific Attributes](#replication-specific-attributes)
  * [LMTP Specific Attributes](#lmtp-specific-attributes)
  * [Berkeley DB DB_CONFIG Attributes](#berkeley-db-db_config-attributes)
  * [Dictionary Quota SQL Attributes](#dictionary-quota-sql-attributes)
  * [LDAP Authentication Attributes](#ldap-authentication-attributes)
  * [SQL Authentication Attributes](#sql-authentication-attributes)
  * [Distribution Package Names Attributes](#distribution-package-names-attributes)
  * [Distribution Service Configuration](#distribution-service-configuration)
* [Recipes](#recipes)
  * [dovecot::default](#dovecotdefault)
  * [dovecot::user](#dovecotuser)
  * [dovecot::conf_files](#dovecotconf_files)
  * [dovecot::ohai_plugin](#dovecotohai_plugin)
  * [dovecot::from_package](#dovecotfrom_package)
  * [dovecot::service](#dovecotservice)
  * [dovecot::create_pwfile](#dovecotcreate_pwfile)
* [Ohai Plugin](#ohai-plugin)
* [Usage Examples](#usage-examples)
  * [Including in a Cookbook Recipe](#including-in-a-cookbook-recipe)
  * [Including in the Run List](#including-in-the-run-list)
  * [Authentication Database Examples](#authentication-database-examples)
  * [Dictionary Quota SQL Example](#dictionary-quota-sql-example)
  * [Namespaces Example](#namespaces-example)
  * [Plugins Examples](#plugins-examples)
    * [Mail Log Plugin Example](#mail-log-plugin-example)
    * [Sieve Plugin Example](#sieve-plugin-example)
  * [Protocols Examples](#protocols-examples)
  * [Service Examples](#service-examples)
    * [Director Service Example](#director-service-example)
    * [Imap-login Service Example](#imap-login-service-example)
    * [Doveadm Service Example](#doveadm-service-example)
    * [Quota-status Service Example](#quota-status-service-example)
    * [Quota-warning Service Example](#quota-warning-service-example)
  * [LDAP Example](#ldap-example)
  * [Password File Example](#password-file-example)
  * [A Complete Example](#a-complete-example)
* [Testing](#testing)
* [Contributing](#contributing)
* [TODO](#todo)
* [License and Author](#license-and-author)

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon
* CentOS `>= 6.0`
* Debian `>= 7.0`
* Fedora `>= 18.0`
* OpenSUSE
* Oracle Linux  `>= 6.0`
* Scientific Linux  `>= 6.0`
* SUSE
* Ubuntu `>= 12.04`

Let me know if you use it successfully on any other platform.

## Required Cookbooks

* [ohai](https://supermarket.chef.io/cookbooks/ohai)

## Required Applications

* Chef `12` or higher.
* Ruby `2.2` or higher.
* **Dovecot `>= 2`**: requires this version of dovecot to be available by the distribution's package manager.

Attributes
==========

To see a more complete description of the attributes, go to the [Dovecot wiki2 configuration section](http://wiki2.dovecot.org/#Dovecot_configuration) or read the comments in the templates and generated configuration files.

| Attribute                                         | Default                    | Description                    |
|:--------------------------------------------------|:---------------------------|:-------------------------------|
| `node['dovecot']['install_from']`                 | `'package'`                | Determines how Dovecot is installed from. Only `'package'` is supported for now.
| `node['dovecot']['user']`                         | `'dovecot'`                | Dovecot system user. Should no be changed.
| `node['dovecot']['group']`                        | `'dovecot'`                | Dovecot system group. Should no be changed.
| `node['dovecot']['user_homedir']`                 | *calculated*               | Dovecot system user home directory.
| `node['dovecot']['lib_path']`                     | *calculated*               | Dovecot library path. Should no be changed.
| `node['dovecot']['conf_path']`                    | `'/etc/dovecot'`           | Dovecot configuration files path. Should no be changed.
| `node['dovecot']['conf_files_user']`              | `'root'`                   | System user owner of configuration files.
| `node['dovecot']['conf_files_group']`             | `node['dovecot']['group']` | System group owner of configuration files.
| `node['dovecot']['conf_files_mode']`              | `00644`                    | Configuration files system file mode bits.
| `node['dovecot']['sensitive_files']`              | `['*.conf.ext']`           | An array of dovecot sensitive configuration files. Each array item can be a glob expression or a fixed file name. These file names should be relative to `node['dovecot']['conf_path']` directory. Example: `['dovecot-sql.conf.ext', '*-auth.conf.ext', 'conf.d/auth-supersecret.conf.ext']`.
| `node['dovecot']['sensitive_files_mode']`         | `00640`                    | Configuration files system file mode bits for sensitve files.
| `node['dovecot']['conf_files']['core']`           | *calculated*               | Dovecot core configuration files list.
| `node['dovecot']['conf_files']['imap']`           | `['conf.d/20-imap.conf']`  | Dovecot IMAP configuration files list.
| `node['dovecot']['conf_files']['pop3']`           | `['conf.d/20-pop3.conf']`  | Dovecot POP3 configuration files list.
| `node['dovecot']['conf_files']['lmtp']`           | `['conf.d/20-lmtp.conf']`  | Dovecot LMTP configuration files list.
| `node['dovecot']['conf_files']['sieve']`          | *calculated*               | Dovecot Sieve configuration files list.
| `node['dovecot']['conf_files']['ldap']`           | *calculated*               | Dovecot LDAP configuration files list.
| `node['dovecot']['auth']`                         | `{}`                       | Dovecot Authentication Databases as a hash of hashes ([see the examples below](#authentication-database-examples)). Supported authdbs: checkpassword, deny, ldap, master, passwdfile, sql, system and vpopmail.
| `node['dovecot']['namespaces']`                   | `[]`                       | Dovecot Namespaces as an array of hashes ([see the example below](#namespaces-example)).
| `node['dovecot']['plugins']`                      | *calculated*               | Dovecot Plugins configuration as a hash of hashes ([see the examples below](#plugins-examples)). Supported plugins: mail_log, acl and quota.
| `node['dovecot']['protocols']`                    | `{}`                       | Dovecot Protocols configuration as a hash of hashes ([see the example below](#protocols-example)). Supported protocols: lda, imap, lmtp, sieve and pop3.
| `node['dovecot']['services']`                     | `{}`                       | Dovecot Services configuration as a hash of hashes ([see the examples below](#service-examples)). Supported services: anvil, director, imap-login, pop3-login, lmtp, imap, pop3, auth, auth-worker, dict, tcpwrap, managesieve-login managesieve, quota-status, quota-warning and doveadm.
| `node['dovecot']['conf']['mail_plugins']`         | `[]`                       | Dovecot default enabled mail_plugins.
| `node['dovecot']['ohai_plugin']['build-options']` | `true`                     | Whether to enable reading build options inside ohai plugin. Can be disabled to be lighter.
| `node['dovecot']['databag_name']`              | `dovecot`                  | The databag to use.
| `node['dovecot']['databag_users_item']`         | `users`                    | The databag item to use for User's database (Passwords).
| `node['dovecot']['conf']['password_file']`      | `#{node['dovecot']['conf_path']}/password` | The Password file location

## Main Configuration Attributes

* Configuration file: `dovecot.conf`.

| Attribute                                           | Default | Description                    |
|:----------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['listen']`                 | *nil*   | A comma separated list of IPs or hosts where to listen in for connections.
| `node['dovecot']['conf']['base_dir']`               | *nil*   | Base directory where to store runtime data.
| `node['dovecot']['conf']['instance_name']`          | *nil*   | Name of this instance. Used to prefix all Dovecot processes in ps output.
| `node['dovecot']['conf']['login_greeting']`         | *nil*   | Greeting message for clients.
| `node['dovecot']['conf']['login_trusted_networks']` | *nil*   | Space separated list of trusted network ranges.
| `node['dovecot']['conf']['login_access_sockets']`   | *nil*   | Space separated list of login access check sockets.
| `node['dovecot']['conf']['auth_proxy_self']`        | *nil*   | With proxy_maybe=yes if proxy destination matches any of these IPs, don't do proxying.
| `node['dovecot']['conf']['verbose_proctitle']`      | *nil*   | Show more verbose process titles (in ps).
| `node['dovecot']['conf']['shutdown_clients']`       | *nil*   | Should all processes be killed when Dovecot master process shuts down.
| `node['dovecot']['conf']['doveadm_worker_count']`   | *nil*   | If non-zero, run mail commands via this many connections to doveadm server.
| `node['dovecot']['conf']['doveadm_socket_path']`    | *nil*   | UNIX socket or host:port used for connecting to doveadm server.
| `node['dovecot']['conf']['import_environment']`     | *nil*   | Space separated list of environment variables that are preserved on Dovecot startup and his childs.
| `node['dovecot']['conf']['dict']`                   | *nil*   | Dictionary server settings as a hash.

## Authentication Processes Attributes

* Configuration file: `conf.d/10-auth.conf`.

| Attribute                                                 | Default   | Description                    |
|:----------------------------------------------------------|:----------|:-------------------------------|
| `node['dovecot']['conf']['disable_plaintext_auth']`       | *nil*     | Disable LOGIN command and all other plaintext authentications unless SSL/TLS is used.
| `node['dovecot']['conf']['auth_cache_size']`              | *nil*     | Authentication cache size (e.g. 10M). 0 means it's disabled.
| `node['dovecot']['conf']['auth_cache_ttl']`               | *nil*     | Time to live for cached data.
| `node['dovecot']['conf']['auth_cache_negative_ttl']`      | *nil*     | TTL for negative hits (user not found, password mismatch).
| `node['dovecot']['conf']['auth_realms']`                  | *nil*     | Space separated list (or array) of realms for SASL authentication mechanisms that need them.
| `node['dovecot']['conf']['auth_default_realm']`           | *nil*     | Default realm/domain to use if none was specified.
| `node['dovecot']['conf']['auth_username_chars']`          | *nil*     | List of allowed characters in username.
| `node['dovecot']['conf']['auth_username_translation']`    | *nil*     | Username character translations before it's looked up from databases.
| `node['dovecot']['conf']['auth_username_format']`         | *nil*     | Username formatting before it's looked up from databases.
| `node['dovecot']['conf']['auth_master_user_separator']`   | *nil*     | If you want to allow master users to log in by specifying the master username within the normal username string, you can specify the separator character here (format: `<username><separator><master username>`).
| `node['dovecot']['conf']['auth_anonymous_username']`      | *nil*     | Username to use for users logging in with ANONYMOUS SASL mechanism.
| `node['dovecot']['conf']['auth_worker_max_count']`        | *nil*     | Maximum number of dovecot-auth worker processes.
| `node['dovecot']['conf']['auth_gssapi_hostname']`         | *nil*     | Host name to use in GSSAPI principal names.
| `node['dovecot']['conf']['auth_krb5_keytab']`             | *nil*     | Kerberos keytab to use for the GSSAPI mechanism.
| `node['dovecot']['conf']['auth_use_winbind']`             | *nil*     | Do NTLM and GSS-SPNEGO authentication using Samba's winbind daemon and ntlm_auth helper.
| `node['dovecot']['conf']['auth_winbind_helper_path']`     | *nil*     | Path for Samba's ntlm_auth helper binary.
| `node['dovecot']['conf']['auth_failure_delay']`           | *nil*     | Time to delay before replying to failed authentications.
| `node['dovecot']['conf']['auth_ssl_require_client_cert']` | *nil*     | Take the username from client's SSL certificate, using X509_NAME_get_text_by_NID() which returns the subject's DN's CommonName.
| `node['dovecot']['conf']['auth_mechanisms']`              | `'plain'` | Space separated list of wanted authentication mechanisms: plain, login, digest-md5, cram-md5, ntlm, rpa, apop, anonymous, gssapi, otp, skey, gss-spnego.

## Director-specific Attributes

* Configuration file: `conf.d/10-director.conf`.

| Attribute                                           | Default | Description                    |
|:----------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['director_servers']`       | *nil*   | List of IPs or hostnames to all director servers, including ourself (as a string or as an array).
| `node['dovecot']['conf']['director_mail_servers']`  | *nil*   | List of IPs or hostnames to all backend mail servers.
| `node['dovecot']['conf']['director_user_expire']`   | *nil*   | How long to redirect users to a specific server after it no longer has any connections.
| `node['dovecot']['conf']['director_doveadm_port']`  | *nil*   | TCP/IP port that accepts doveadm connections (instead of director connections).
| `node['dovecot']['conf']['director_username_hash']` | *nil*   | How the username is translated before being hashed.

## Log Destination Attributes

* Configuration file: `conf.d/10-logging.conf`.

| Attribute                                              | Default | Description                    |
|:-------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['log_path']`                  | *nil*   | Log file to use for error messages. "syslog" logs to syslog, /dev/stderr logs to stderr.
| `node['dovecot']['conf']['info_log_path']`             | *nil*   | Log file to use for informational messages. Defaults to log_path.
| `node['dovecot']['conf']['debug_log_path']`            | *nil*   | Log file to use for debug messages. Defaults to info_log_path.
| `node['dovecot']['conf']['syslog_facility']`           | *nil*   | Syslog facility to use if you're logging to syslog.
| `node['dovecot']['conf']['auth_verbose']`              | *nil*   | Log unsuccessful authentication attempts and the reasons why they failed.
| `node['dovecot']['conf']['auth_verbose_passwords']`    | *nil*   | In case of password mismatches, log the attempted password.
| `node['dovecot']['conf']['auth_debug']`                | *nil*   | Even more verbose logging for debugging purposes.
| `node['dovecot']['conf']['auth_debug_passwords']`      | *nil*   | In case of password mismatches, log the passwords and used scheme so the problem can be debugged.
| `node['dovecot']['conf']['mail_debug']`                | *nil*   | Enable mail process debugging.
| `node['dovecot']['conf']['verbose_ssl']`               | *nil*   | Show protocol level SSL errors.
| `node['dovecot']['conf']['log_timestamp']`             | *nil*   | Prefix for each line written to log file.
| `node['dovecot']['conf']['login_log_format_elements']` | *nil*   | Space-separated list (or array) of elements we want to log.
| `node['dovecot']['conf']['login_log_format']`          | *nil*   | Login log format.
| `node['dovecot']['conf']['mail_log_prefix']`           | *nil*   | Log prefix for mail processes.
| `node['dovecot']['conf']['deliver_log_format']`        | *nil*   | Format to use for logging mail deliveries.

## Mailbox Locations and Namespaces Attributes

* Configuration file: `conf.d/10-mail.conf`.

| Attribute                                                  | Default | Description                    |
|:-----------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['mail_location']`                 | *nil*   | Location for user's mailboxes.
| `node['dovecot']['conf']['mail_shared_explicit_inbox']`    | *nil*   | Should shared INBOX be visible as "shared/user" or "shared/user/INBOX"?.
| `node['dovecot']['conf']['mail_uid']`                      | *nil*   | System user used to access mails.
| `node['dovecot']['conf']['mail_gid']`                      | *nil*   | System group used to access mails.
| `node['dovecot']['conf']['mail_privileged_group']`         | *nil*   | Group to enable temporarily for privileged operations.
| `node['dovecot']['conf']['mail_access_groups']`            | *nil*   | Grant access to these supplementary groups for mail processes.
| `node['dovecot']['conf']['mail_full_filesystem_access']`   | *nil*   | Allow full filesystem access to clients.
| `node['dovecot']['conf']['mail_attribute_dict']`           | *nil*   | Dictionary for key=value mailbox attributes.
| `node['dovecot']['conf']['mail_server_comment']`           | *nil*   | A comment or note that is associated with the server.
| `node['dovecot']['conf']['mail_server_admin']`             | *nil*   | Indicates a method for contacting the server administrator. This value MUST be a URI.
| `node['dovecot']['conf']['mmap_disable']`                  | *nil*   | Don't use mmap() at all.
| `node['dovecot']['conf']['dotlock_use_excl']`              | *nil*   | Rely on O_EXCL to work when creating dotlock files.
| `node['dovecot']['conf']['mail_fsync']`                    | *nil*   | When to use fsync() or fdatasync() calls: optimized, always or never.
| `node['dovecot']['conf']['mail_nfs_storage']`              | *nil*   | Mail storage exists in NFS.
| `node['dovecot']['conf']['mail_nfs_index']`                | *nil*   | Mail index files also exist in NFS.
| `node['dovecot']['conf']['lock_method']`                   | *nil*   | Locking method for index files: fcntl, flock or dotlock.
| `node['dovecot']['conf']['mail_temp_dir']`                 | *nil*   | Directory in which LDA/LMTP temporarily stores incoming mails &gt;128 kB.
| `node['dovecot']['conf']['first_valid_uid']`               | *nil*   | Valid UID range for users, defaults to 500 and above.
| `node['dovecot']['conf']['last_valid_uid']`                | *nil*   | Valid UID range for users, defaults to 500 and above.
| `node['dovecot']['conf']['first_valid_gid']`               | *nil*   | Valid GID range for users, defaults to non-root/wheel.
| `node['dovecot']['conf']['last_valid_gid']`                | *nil*   | Valid GID range for users, defaults to non-root/wheel.
| `node['dovecot']['conf']['mail_max_keyword_length']`       | *nil*   | Maximum allowed length for mail keyword name.
| `node['dovecot']['conf']['valid_chroot_dirs']`             | *nil*   | ':' separated list of directories under which chrooting is allowed for mail processes.
| `node['dovecot']['conf']['mail_chroot']`                   | *nil*   | Default chroot directory for mail processes.
| `node['dovecot']['conf']['auth_socket_path']`              | *nil*   | UNIX socket path to master authentication server to find users.
| `node['dovecot']['conf']['mail_plugin_dir']`               | *nil*   | Directory where to look up mail plugins.
| `node['dovecot']['conf']['mail_cache_min_mail_count']`     | *nil*   | The minimum number of mails in a mailbox before updates are done to cache file.
| `node['dovecot']['conf']['mailbox_idle_check_interval']`   | *nil*   | When IDLE command is running, mailbox is checked once in a while to see if there are any new mails or other changes.
| `node['dovecot']['conf']['mail_save_crlf']`                | *nil*   | Save mails with CR+LF instead of plain LF.
| `node['dovecot']['conf']['mail_prefetch_count']`           | *nil*   | Max number of mails to keep open and prefetch to memory.
| `node['dovecot']['conf']['mail_temp_scan_interval']`       | *nil*   | How often to scan for stale temporary files and delete them (0 = never).
| `node['dovecot']['conf']['maildir_stat_dirs']`             | *nil*   | By default LIST command returns all entries in maildir beginning with a dot.
| `node['dovecot']['conf']['maildir_copy_with_hardlinks']`   | *nil*   | When copying a message, do it with hard links whenever possible.
| `node['dovecot']['conf']['maildir_very_dirty_syncs']`      | *nil*   | Assume Dovecot is the only MUA accessing Maildir.
| `node['dovecot']['conf']['maildir_broken_filename_sizes']` | *nil*   | If enabled, Dovecot doesn't use the `S=<size>` in the Maildir filenames for getting the mail's physical size, except when recalculating Maildir++ quota.
| `node['dovecot']['conf']['maildir_empty_new']`             | *nil*   | Always move mails from new/ directory to cur/, even when the \Recent flags aren't being reset.
| `node['dovecot']['conf']['mbox_read_locks']`               | *nil*   | Which read locking methods to use for locking mbox: dotlock, dotlock_try, fcntl, flock or lockf.
| `node['dovecot']['conf']['mbox_write_locks']`              | *nil*   | Which write locking methods to use for locking mbox: dotlock, dotlock_try, fcntl, flock or lockf.
| `node['dovecot']['conf']['mbox_lock_timeout']`             | *nil*   | Maximum time to wait for lock (all of them) before aborting.
| `node['dovecot']['conf']['mbox_dotlock_change_timeout']`   | *nil*   | If dotlock exists but the mailbox isn't modified in any way, override the lock file after this much time.
| `node['dovecot']['conf']['mbox_dirty_syncs']`              | *nil*   | When mbox changes unexpectedly simply read the new mails but still safely fallbacks to re-reading the whole mbox file whenever something in mbox isn't how it's expected to be.
| `node['dovecot']['conf']['mbox_very_dirty_syncs']`         | *nil*   | Like mbox_dirty_syncs, but don't do full syncs even with SELECT, EXAMINE, EXPUNGE or CHECK commands.
| `node['dovecot']['conf']['mbox_lazy_writes']`              | *nil*   | Delay writing mbox headers until doing a full write sync (EXPUNGE and CHECK commands and when closing the mailbox).
| `node['dovecot']['conf']['mbox_min_index_size']`           | *nil*   | If mbox size is smaller than this (e.g. 100k), don't write index files.
| `node['dovecot']['conf']['mbox_md5']`                      | *nil*   | Mail header selection algorithm to use for MD5 POP3 UIDLs when pop3_uidl_format=%m.
| `node['dovecot']['conf']['mdbox_rotate_size']`             | *nil*   | Maximum dbox file size until it's rotated.
| `node['dovecot']['conf']['mdbox_rotate_interval']`         | *nil*   | Maximum dbox file age until it's rotated.
| `node['dovecot']['conf']['mdbox_preallocate_space']`       | *nil*   | When creating new mdbox files, immediately preallocate their size to mdbox_rotate_size.
| `node['dovecot']['conf']['mail_attachment_dir']`           | *nil*   | Directory root where to store mail attachments. Disabled, if empty.
| `node['dovecot']['conf']['mail_attachment_min_size']`      | *nil*   | Attachments smaller than this aren't saved externally.
| `node['dovecot']['conf']['mail_attachment_fs']`            | *nil*   | Filesystem backend to use for saving attachments: posix, sis posix or sis-queue posix.
| `node['dovecot']['conf']['mail_attachment_hash']`          | *nil*   | Hash format to use in attachment filenames.

## Master Configuration File Attributes

* Configuration file: `conf.d/10-master.conf`.

| Attribute                                          | Default | Description                    |
|:---------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['default_process_limit']` | *nil*   | Default process limit.
| `node['dovecot']['conf']['default_client_limit']`  | *nil*   | Default client limit.
| `node['dovecot']['conf']['default_vsz_limit']`     | *nil*   | Default VSZ (virtual memory size) limit for service processes.
| `node['dovecot']['conf']['default_login_user']`    | *nil*   | Login user is internally used by login processes.
| `node['dovecot']['conf']['default_internal_user']` | *nil*   | Internal user is used by unprivileged processes.

## SSL Attributes

* Configuration file: `conf.d/10-ssl.conf`.

| Attribute                                              | Default      | Description                    |
|:-------------------------------------------------------|:-------------|:-------------------------------|
| `node['dovecot']['conf']['ssl']`                       | *calculated* | SSL/TLS support: `true` or `false`.
| `node['dovecot']['conf']['ssl_cert']`                  | *calculated* | PEM encoded X.509 SSL/TLS certificate.
| `node['dovecot']['conf']['ssl_key']`                   | *calculated* | PEM encoded X.509 SSL/TLS private key.
| `node['dovecot']['conf']['ssl_key_password']`          | *nil*        | If key file is password protected, give the password here.
| `node['dovecot']['conf']['ssl_ca']`                    | *nil*        | PEM encoded trusted certificate authority.
| `node['dovecot']['conf']['ssl_require_crl']`           | *nil*        | Require that CRL check succeeds for client certificates.
| `node['dovecot']['conf']['ssl_client_ca_dir']`         | *nil*        | Directory for trusted SSL CA certificates. These are used only when Dovecot needs to act as an SSL client.
| `node['dovecot']['conf']['ssl_client_ca_file']`        | *nil*        | File for trusted SSL CA certificates. These are used only when Dovecot needs to act as an SSL client.
| `node['dovecot']['conf']['ssl_verify_client_cert']`    | *nil*        | Request client to send a certificate.
| `node['dovecot']['conf']['ssl_cert_username_field']`   | *nil*        | Which field from certificate to use for username.
| `node['dovecot']['conf']['ssl_parameters_regenerate']` | *nil*        | How often to regenerate the SSL parameters file.
| `node['dovecot']['conf']['ssl_dh_parameters_length']`  | *nil*        | DH parameters length to use.
| `node['dovecot']['conf']['ssl_protocols']`             | *nil*        | SSL protocols to use.
| `node['dovecot']['conf']['ssl_cipher_list']`           | *nil*        | SSL ciphers to use.
| `node['dovecot']['conf']['ssl_prefer_server_ciphers']` | *nil*        | Prefer the server's order of ciphers over client's.
| `node['dovecot']['conf']['ssl_crypto_device']`         | *nil*        | SSL crypto device to use, for valid values run `$ openssl engine`.
| `node['dovecot']['conf']['ssl_options']`               | *nil*        | SSL extra options. Currently supported options are: `'no_compression'`.

## LDA Specific Attributes

Also used by LMTP.

* Configuration files: `conf.d/15-lda.conf`.

| Attribute                                                  | Default | Description                    |
|:-----------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['postmaster_address']`            | *nil*   | Address to use when sending rejection mails.
| `node['dovecot']['conf']['hostname']`                      | *nil*   | Hostname to use in various parts of sent mails, eg. in Message-Id.
| `node['dovecot']['conf']['quota_full_tempfail']`           | *nil*   | If user is over quota, return with temporary failure instead of bouncing the mail.
| `node['dovecot']['conf']['sendmail_path']`                 | *nil*   | Binary to use for sending mails.
| `node['dovecot']['conf']['submission_host']`               | *nil*   | If non-empty, send mails via this SMTP host[:port] instead of sendmail.
| `node['dovecot']['conf']['rejection_subject']`             | *nil*   | Subject: header to use for rejection mails.
| `node['dovecot']['conf']['rejection_reason']`              | *nil*   | Human readable error message for rejection mails.
| `node['dovecot']['conf']['recipient_delimiter']`           | *nil*   | Delimiter character between local-part and detail in email address.
| `node['dovecot']['conf']['lda_original_recipient_header']` | *nil*   | Header where the original recipient address (SMTP's RCPT TO: address) is taken from if not available elsewhere.
| `node['dovecot']['conf']['lda_mailbox_autocreate']`        | *nil*   | Should saving a mail to a nonexistent mailbox automatically create it?
| `node['dovecot']['conf']['lda_mailbox_autosubscribe']`     | *nil*   | Should automatically created mailboxes be also automatically subscribed?

## Replication Specific Attributes

Also used by Replication/sync of dovecot.

* Configuration files: `conf.d/15-replication.conf`.

| Attribute                                                  | Default | Description                    |
|:-----------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['doveadm_port']`                  | *nil*   | Used to set a default port for the doveadm replication commands.
| `node['dovecot']['conf']['doveadm_password']`              | *nil*   | Needed to set an 'secret' for the replication communication between to servers.


## LMTP Specific Attributes

* Configuration file: `conf.d/20-lmtp.conf`

| Attribute                                                | Default | Description                    |
|:---------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['lmtp_proxy']`                  | *nil*   | Support proxying to other LMTP/SMTP servers by performing passdb lookups.
| `node['dovecot']['conf']['lmtp_save_to_detail_mailbox']` | *nil*   | When recipient address includes the detail (e.g. user+detail), try to save the mail to the detail mailbox.
| `node['dovecot']['conf']['lmtp_rcpt_check_quota']`       | *nil*   | Verify quota before replying to RCPT TO. This adds a small overhead.
| `node['dovecot']['conf']['lmtp_hdr_delivery_address']`   | *nil*   |  Which recipient address to use for Delivered-To: header and Received: header.
## Berkeley DB DB_CONFIG Attributes

* Configuration file: `dovecot-db.conf.ext`.

| Attribute                       | Default | Description                    |
|:--------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['db']` | *nil*   | DB_CONFIG for Berkeley DB as a hash.

## Dictionary Quota SQL Attributes

* Configuration files: `dovecot-dict-sql.conf.ext`.

| Attribute                                        | Default | Description                    |
|:-------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['dict_sql']['connect']` | *nil*   | Dict sql connect configuration as a string or an array.
| `node['dovecot']['conf']['dict_sql']['maps']`    | *nil*   | Dict sql database tables maps ([see the example below](#dictionary-quota-sql-example)).

## LDAP Authentication Attributes

* Configuration files: `dovecot-ldap.conf.ext`.

| Attribute                                                | Default | Description                    |
|:---------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['ldap']['hosts']`               | *nil*   | Space separated list or array of LDAP hosts to use.
| `node['dovecot']['conf']['ldap']['uris']`                | *nil*   | LDAP URIs to use.
| `node['dovecot']['conf']['ldap']['dn']`                  | *nil*   | Distinguished Name, the username used to login to the LDAP server.
| `node['dovecot']['conf']['ldap']['dnpass']`              | *nil*   | Password for LDAP server, if dn is specified.
| `node['dovecot']['conf']['ldap']['sasl_bind']`           | *nil*   | Use SASL binding instead of the simple binding.
| `node['dovecot']['conf']['ldap']['sasl_mech']`           | *nil*   | SASL mechanism name to use.
| `node['dovecot']['conf']['ldap']['sasl_realm']`          | *nil*   | SASL realm to use.
| `node['dovecot']['conf']['ldap']['sasl_authz_id']`       | *nil*   | SASL authorization ID, ie. the dnpass is for this "master user", but the dn is still the logged in user.
| `node['dovecot']['conf']['ldap']['tls']`                 | *nil*   | Use TLS to connect to the LDAP server.
| `node['dovecot']['conf']['ldap']['tls_ca_cert_file']`    | *nil*   | TLS options, currently supported only with OpenLDAP.
| `node['dovecot']['conf']['ldap']['tls_ca_cert_dir']`     | *nil*   | TLS options, currently supported only with OpenLDAP.
| `node['dovecot']['conf']['ldap']['tls_cipher_suite']`    | *nil*   | TLS options, currently supported only with OpenLDAP.
| `node['dovecot']['conf']['ldap']['tls_cert_file']`       | *nil*   | TLS cert/key is used only if LDAP server requires a client certificate.
| `node['dovecot']['conf']['ldap']['tls_key_file']`        | *nil*   | TLS cert/key is used only if LDAP server requires a client certificate.
| `node['dovecot']['conf']['ldap']['tls_require_cert']`    | *nil*   | Valid values: never, hard, demand, allow, try.
| `node['dovecot']['conf']['ldap']['ldaprc_path']`         | *nil*   | Use the given ldaprc path.
| `node['dovecot']['conf']['ldap']['debug_level']`         | *nil*   | LDAP library debug level as specified by LDAP_DEBUG_* in ldap_log.h.
| `node['dovecot']['conf']['ldap']['auth_bind']`           | *nil*   | Use authentication binding for verifying password's validity.
| `node['dovecot']['conf']['ldap']['auth_bind_userdn']`    | *nil*   | If authentication binding is used, you can save one LDAP request per login if user's DN can be specified with a common template.
| `node['dovecot']['conf']['ldap']['ldap_version']`        | *nil*   | LDAP protocol version to use. Likely 2 or 3.
| `node['dovecot']['conf']['ldap']['base']`                | *nil*   | LDAP base. %variables can be used here.
| `node['dovecot']['conf']['ldap']['deref']`               | *nil*   | Dereference: never, searching, finding or always.
| `node['dovecot']['conf']['ldap']['scope']`               | *nil*   | Search scope: base, onelevel or subtree.
| `node['dovecot']['conf']['ldap']['user_attrs']`          | *nil*   | User attributes are given in LDAP-name=dovecot-internal-name list.
| `node['dovecot']['conf']['ldap']['user_filter']`         | *nil*   | Filter for user lookup.
| `node['dovecot']['conf']['ldap']['pass_attrs']`          | *nil*   | Password checking attributes.
| `node['dovecot']['conf']['ldap']['pass_filter']`         | *nil*   | Filter for password lookups.
| `node['dovecot']['conf']['ldap']['iterate_attrs']`       | *nil*   | Attributes to get a list of all users.
| `node['dovecot']['conf']['ldap']['iterate_filter']`      | *nil*   | Filter to get a list of all users.
| `node['dovecot']['conf']['ldap']['default_pass_scheme']` | *nil*   | Default password scheme. "{scheme}" before password overrides this.

## SQL Authentication Attributes

* Configuration file: `dovecot-sql.conf.ext`.

| Attribute                                               | Default | Description                    |
|:--------------------------------------------------------|:--------|:-------------------------------|
| `node['dovecot']['conf']['sql']['driver']`              | *nil*   | Database driver: mysql, pgsql or sqlite.
| `node['dovecot']['conf']['sql']['connect']`             | *nil*   | Database connection string or array. This is driver-specific setting.
| `node['dovecot']['conf']['sql']['default_pass_scheme']` | *nil*   | Default password scheme.
| `node['dovecot']['conf']['sql']['password_query']`      | *nil*   | passdb query to retrieve the password.
| `node['dovecot']['conf']['sql']['user_query']`          | *nil*   | userdb query to retrieve the user information.
| `node['dovecot']['conf']['sql']['iterate_query']`       | *nil*   | Query to get a list of all usernames.


## Distribution Package Names Attributes

These attributes below contain the default required distribution packages for the supported platforms. But you are free to create your own to support other platforms. Keep in mind that all are put inside a subkey (`type`). This `node['dovecot']['packages'][type]` attribute is then used together with the `node['dovecot']['conf_files'][type]` attribute to generate the configuration files.

| Attribute                               | Default      | Description                    |
|:----------------------------------------|:-------------|:-------------------------------|
| `node['dovecot']['packages']['core']`   | *calculated* | Dovecot core package names array.
| `node['dovecot']['packages']['imap']`   | *calculated* | Dovecot IMAP package names array.
| `node['dovecot']['packages']['pop3']`   | *calculated* | Dovecot POP3 package names array.
| `node['dovecot']['packages']['lmtp']`   | *calculated* | Dovecot LMTP package names array.
| `node['dovecot']['packages']['sieve']`  | *calculated* | Dovecot Sieve package names array.
| `node['dovecot']['packages']['ldap']`   | *calculated* | Dovecot LDAP package names array.
| `node['dovecot']['packages']['sqlite']` | *calculated* | Dovecot SQLite package names array.
| `node['dovecot']['packages']['mysql']`  | *calculated* | Dovecot MySQL package names array.
| `node['dovecot']['packages']['pgsql']`  | *calculated* | Dovecot PostgreSQL package names array.

## Distribution Service Configuration

These attributes are used to configure the Dovecot service according to each distribution. Surely you want to change them if you want to support new platforms or want to improve the support of some platforms already supported.

| Attribute                                | Default      | Description                       |
|:-----------------------------------------|:-------------|:----------------------------------|
| `node['dovecot']['service']['name']`     | `'dovecot'`  | Dovecot system service name.
| `node['dovecot']['service']['supports']` | *calculated* | Dovecot service supported actions.
| `node['dovecot']['service']['provider']` | *calculated* | Dovecot service Chef provider class.

Recipes
=======

## dovecot::default

Installs and configures Dovecot.

## dovecot::user

Creates the dovecot system user. Used by the default recipe.

## dovecot::conf_files

Generates all the configuration files. Used by the default recipe.

## dovecot::ohai_plugin

Provides an Ohai plugin for reading dovecot install information.

## dovecot::from_package

Installs the required packages. Used by the default recipe if `node['dovecot']['install_from]` is `package`.

## dovecot::service

Configures the Dovecot service. Used by the default recipe.

## dovecot::create_pwfile

Creates and configures a password file from local mailboxes based on a data bag.


* `node['dovecot']['databag_name']`: The Databag on which items are stored.
* `node['dovecot']['databag_users_item']`: The databag item to use (under the databag set)

Ohai Plugin
===========

The `ohai_plugin` recipe installs an Ohai plugin. It will be installed and activated automatically.

It will set the following attributes:

* `node['dovecot']['version']`: version of Dovecot.
* `node['dovecot']['build-options']`: some Dovecot build options.
 * `node['dovecot']['build-options']['mail-storages']`
 * `node['dovecot']['build-options']['sql-driver-plugins']` or `node['dovecot']['build-options']['sql-drivers']`
 * `node['dovecot']['build-options']['passdb']`
 * `node['dovecot']['build-options']['userdb']`

This is an output example:

```json
"dovecot": {
  "version": "2.0.19",
  "build-options": {
    "ioloop": "epoll",
    "notify": "inotify",
    "ipv6": true,
    "openssl": true,
    "io_block_size": "8192",
    "mail-storages": [
      "shared",
      "mdbox",
      "sdbox",
      "maildir",
      "mbox",
      "cydir",
      "raw"
    ],
    "sql-driver-plugins": [
      "mysql",
      "postgresql",
      "sqlite"
    ],
    "passdb": [
      "checkpassword",
      "ldap",
      "pam",
      "passwd",
      "passwd-file",
      "shadow",
      "sql"
    ],
    "userdb": [
      "checkpassword",
      "ldap(plugin)",
      "nss",
      "passwd",
      "prefetch",
      "passwd-file",
      "sql"
    ]
  }
}
```

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
# [...]

depends 'dovecot'
```

## Including in the Run List

Another alternative is to include the default recipe in your Run List.

```json
{
  "name": "mail.example.com",
  "[...]": "[...]",
  "run_list": [
    "recipe[dovecot]"
  ]
}
```

## Authentication Database Examples

Authentication database attributes, inside passdb or usedb hash values, can contain both arrays or hashes.

Supported auths are the following: `checkpassword`, `deny`, `ldap`, `master`, `passwdfile`, `sql`, `system` and `vpopmail`.

```ruby
node.default['dovecot']['auth']['checkpassword'] =
  {
    'passdb' => { # hash
      'driver' => 'checkpassword',
      'args' => '/usr/bin/checkpassword'
    },
    'userdb' => {
      'driver' => 'prefetch'
    }
  }
```

```ruby
node.default['dovecot']['auth']['system']['passdb'] =
  [ # array
    {
      # without driver
      'args' => 'dovecot'
    },
    {
      'driver' => 'passwd',
      'args' => ''
    },
    {
      'driver' => 'shadow',
      'args' => ''
    },
    {
      'driver' => 'bsdauth',
      'args' => ''
    }
  ]
```

## Dictionary Quota SQL Example

```ruby
node.default['dovecot']['conf']['dict_sql']['maps'] =
  [
    {
      'pattern' => 'priv/quota/storage',
      'table' => 'quota',
      'username_field' => 'username',
      'value_field' => 'bytes'
    },
    {
      'pattern' => 'priv/quota/messages',
      'table' => 'quota',
      'username_field' => 'username',
      'value_field' => 'messages'
    },
    {
      'pattern' => 'shared/expire/$user/$mailbox',
      'table' => 'expires',
      'value_field' => 'expire_stamp',
      'fields' => {
        'username' => '$user',
        'mailbox' => '$mailbox'
      }
    }
  ]
```

## Namespaces Example

The `['namespaces']` attribute is an array, which could contain both array or hash values.

```ruby
node.default['dovecot']['namespaces'] = [
  {
    'separator' => '/',
    'prefix' => '"#mbox/"',
    'location' => 'mbox:~/mail:INBOX=/var/mail/%u',
    'inbox' => true,
    'hidden' => true,
    'list' => false
  }, {
    'separator' => '/',
    'prefix' => '',
    'location' => 'maildir:~/Maildir'
  }, { # this requires Dovecot >= 2.1
    'name' => 'inbox',
    'separator' => '/',
    'prefix' => '',
    'inbox' => true,
    'mailboxes' => {
      'Drafts' => {
        'special_use' => '\Drafts'
      },
      'Junk' => {
        'special_use' => '\Junk'
      },
      'Trash' => {
        'special_use' => '\Trash'
      },
      'Sent' => {
        'special_use' => '\Sent'
      },
      'Sent Messages' => {
        'special_use' => '\Sent'
      },
      'virtual/All' => {
        'special_use' => '\All'
      },
      'virtual/Flagged' => {
        'special_use' => '\All'
      }
    }
  }
]
```

## Plugins Examples

Plugin attribute values should be of type hash.

Supported plugins are the following: `mail_log`, `acl` and `quota`.

### Mail Log Plugin Example

```ruby
node.default['dovecot']['plugins']['mail_log'] = {
  'mail_log_events' =>
    'delete undelete expunge copy mailbox_delete mailbox_rename',
  'mail_log_fields' => 'uid box msgid size'
}
```

### Sieve Plugin Example

```ruby
node.default['dovecot']['plugins']['sieve'] = {
  'sieve' => '~/.dovecot.sieve',
  'sieve_dir' => '~/sieve'
}
```

## Protocols Examples

Protocol attribute values should be of type hash.

Supported protocols are the following: `lda`, `imap`, `lmtp`, `sieve` and `pop3`.

```ruby
node.default['dovecot']['protocols']['lda'] = {
  'mail_plugins' => %w($mail_plugins)
}
```

To enable the IMAP protocol without additional settings:

```ruby
node.default['dovecot']['protocols']['imap'] = {}
```

## Service Examples

The `['services']` attribute is a hash. Each service attribute should be a hash. But the `['listeners']` subkey could contain both a hash and an array.

Inside this `listeners` key, you should name each listener with the format *PROTOCOL:NAME*. Allowed protocols are `fifo`, `unix` and `inet`.

Supported services are the following: `anvil`, `director`, `imap-login`, `pop3-login`, `lmtp`, `imap`, `pop3`, `auth`, `auth-worker`, `dict`, `tcpwrap`, `managesieve-login`, `managesieve`, `aggregator`, `replicator`, `config`.

### Director Service Example

```ruby
node.default['dovecot']['services']['director']['listeners'] = [
  { 'unix:login/director' => { 'mode' => '0666' } },
  { 'fifo:login/proxy-notify' => { 'mode' => '0666' } },
  { 'unix:director-userdb' => { 'mode' => '0666' } },
  { 'inet' => { 'port' => '5432' } }
]
```

### Imap-login Service Example

```ruby
node.default['dovecot']['services']['imap-login'] = {
  'listeners' => [
    { 'inet:imap' => { 'port' => 143 } },
    { 'inet:imaps' => { 'port' => 993, 'ssl' => true } }
  ],
  'service_count' => 1,
  'process_min_avail' => 0,
  'vsz_limit' => '64M'
}
```

### Doveadm Service Example

```ruby
default['dovecot']['services']['doveadm'] = {
  'listeners' => [
    { 'inet:doveadm-server' => { 'port' => 3333 }
    }
  ]
}
```

### Quota-status Service Example

```ruby
default['dovecot']['services']['quota-status'] = {
  'executable' => 'quota-status -p postfix',
  'listeners' => [
    { 'inet:imap' => { 'port' => 4444 } }
  ]
}
```

### Quota-warning Service Example

```ruby
default['dovecot']['services']['quota-warning'] = {
  'user' => 'dovecot',
  'executable' => 'script /usr/local/bin/quota-warning.sh',
  'listeners' => [
    { 'unix:quota-warning' => { 'user' => 'postfix' } }
  ]
}
```

## LDAP Example

This is a recipe example to integrate Dovecot with [OpenLDAP](http://www.openldap.org/). The following cookbooks are used:

* [`openldap`](https://supermarket.chef.io/cookbooks/openldap)
* [`ldap`](https://supermarket.chef.io/cookbooks/ldap)

```ruby
# Function to generate the passwords in LDAP format
def generate_ldap_password(password, salt = '12345')
  require 'digest'
  require 'base64'
  digest = Digest::SHA1.digest(password + salt)
  '{SSHA}' + Base64.encode64(digest + salt).chomp
end
recipe = self

# Create LDAP credentials
ldap_password = 'secretsauce'
ldap_credentials = {
  'bind_dn' => "cn=#{node['openldap']['cn']},#{node['openldap']['basedn']}",
  'password' => ldap_password
}

# Configure OpenLDAP server
node.default['openldap']['tls_enabled'] = false
node.default['openldap']['rootpw'] = generate_ldap_password(ldap_password)
node.default['openldap']['loglevel'] = 'any'

include_recipe 'openldap::server'

# Create some LDAP entries as an example

include_recipe 'ldap'

ldap_entry node['openldap']['basedn'] do
  attributes objectClass: %w(top dcObject organization),
             o: 'myorg',
             dc: 'myorg',
             description: 'My organization'
  credentials ldap_credentials
end

ldap_entry "ou=accounts,#{node['openldap']['basedn']}" do
  attributes objectClass: %w(top organizationalUnit),
             ou: 'accounts',
             description: 'Dovecot email accounts'
  credentials ldap_credentials
end

ldap_entry "cn=dovecot,ou=accounts,#{node['openldap']['basedn']}" do
  attributes objectClass: %w(top person),
             cn: 'dovecot',
             sn: 'dovecot'
  credentials ldap_credentials
end

# Create an email account

email_account = {
  cn: 'Ole Wobble Olson',
  sn: 'Olson',
  uid: 'wobble',
  uidNumber: '1002', # should be an string for ldap_entry
  gidNumber: '100',
  homeDirectory: '/home/wobble',
  userPassword: recipe.generate_ldap_password('w0bbl3_p4ss')
}

ldap_entry "uid=wobble,ou=accounts,#{node['openldap']['basedn']}" do
  attributes email_account.merge(objectClass: %w(top person posixAccount))
  credentials ldap_credentials
end

# Create home directory for the email account
directory email_account[:homeDirectory] do
  owner email_account[:uidNumber].to_i # should be an integer for directory
  group email_account[:gidNumber].to_i
end

# Dovecot IMAP configuration
node.default['dovecot']['conf']['mail_location'] = 'maildir:~/Maildir'
node.default['dovecot']['protocols']['imap'] = {}
node.default['dovecot']['services']['imap-login'] =
  {
    'listeners' =>
      [
        { 'inet:imap' => { 'port' => 143 } },
        { 'inet:imaps' => { 'port' => 993, 'ssl' => true } }
      ],
    'service_count' => 1,
    'process_min_avail' => 0,
    'vsz_limit' => '64M'
  }

# Dovecot LDAP configuration
node.default['dovecot']['conf']['ldap']['auth_bind'] = true
node.default['dovecot']['conf']['ldap']['hosts'] = %w(localhost)
node.default['dovecot']['conf']['ldap']['dn'] = ldap_credentials['bind_dn']
node.default['dovecot']['conf']['ldap']['dnpass'] = ldap_credentials['password']
node.default['dovecot']['conf']['ldap']['base'] = node['openldap']['basedn']

include_recipe 'dovecot'
```

## Password File Example

This is an example how to use userdb password file.

```ruby
# Define databag and item inside Databag (default.conf)
node.default['dovecot']'databag_name'] = 'dovecot'
node.default['dovecot']['databag_users_item'] = 'users'

# Attributes for userdb to function
node.default['dovecot']['auth']['passwdfile'] = {
 'passdb' => {
    'driver' => 'passwd-file',
    'args'   => node['dovecot']['conf']['password_file']
 },
 'userdb' => {
    'driver' => 'passwd-file',
    'args'  => "username_format=%u #{node['dovecot']['conf']['password_file']}",
    'default_fields' => 'home=/var/dovecot/vmail/%d/%n'
 }
}


#include this recipe on your
include_recipe 'dovecot::pwfile-file'
```

Databag example.
Two ways of defining an user example included

```json
{
  "users": {
    "dilan": "password1234",
    "vassilis": [
      "vassilis1234",null,null,null,null,null,null
    ]
  }
}
```
## A Complete Example

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
    'group' => 'vmail'
  } },
  # Postfix smtp-auth
  { 'unix:/var/spool/postfix/private/auth' => {
    'mode' => '0666',
    'user' => 'postfix',
    'group' => 'postfix'
  } }
]

# 15-lda.conf
# TODO: Change this to fit your server:
node.default['dovecot']['conf']['postmaster_address'] =
  'postmaster@mycompany.org'
# TODO: Change this to fit your server:
node.default['dovecot']['conf']['hostname'] = 'mail.mycompany.org'
node.default['dovecot']['conf']['lda_mailbox_autocreate'] = true
node.default['dovecot']['conf']['lda_mailbox_autosubscribe'] = true
# We want sieve enabled
node.default['dovecot']['protocols']['lda']['mail_plugins'] =
  %w($mail_plugins sieve)

# 20-imap.conf
# We want IMAP enabled with the default configuration
node.default['dovecot']['protocols']['imap'] = {}

# 90-sieve.conf
node.default['dovecot']['plugins']['sieve']['sieve'] = '~/.dovecot.sieve'
node.default['dovecot']['plugins']['sieve']['sieve_dir'] = '~/sieve'
node.default['dovecot']['plugins']['sieve']['sieve_global_path'] =
  "#{node['dovecot']['conf_path']}/sieve/default.sieve"

# auth-sql.conf.ext
node.default['dovecot']['auth']['sql']['passdb']['args'] =
  '/etc/dovecot/dovecot-sql.conf.ext'
node.default['dovecot']['auth']['sql']['userdb']['args'] =
  '/etc/dovecot/dovecot-sql.conf.ext'

# auth-static.conf.ext
node.default['dovecot']['auth']['static']['userdb']['args'] = %w(
  uid=vmail
  gid=vmail
  home=/var/vmail/%d/%n
  allow_all_users=yes
)

# auth-system.conf.ext
node.default['dovecot']['auth']['system'] = {}

# dovecot-sql.conf.ext
# We want to enable MySQL driver
node.default['dovecot']['conf']['sql']['driver'] = 'mysql'
# TODO: Change the database password below, please:
node.default['dovecot']['conf']['sql']['connect'] = %w(
  host=localhost
  dbname=postfix
  user=postfix
  password=postfix_pass
)
# md5crypt encryption method
node.default['dovecot']['conf']['sql']['default_pass_scheme'] = 'MD5-CRYPT'
node.default['dovecot']['conf']['sql']['password_query'] = [
  'SELECT username AS user, password',
  'FROM mailbox',
  "WHERE username = '%u' AND active = '1'"
]
node.default['dovecot']['conf']['sql']['user_query'] = [
  'SELECT',
  '  username AS user,',
  '  password,',
  '  5000 as uid,',
  '  5000 as gid,',
  "  concat('/var/vmail/', maildir) AS home,",
  "  concat('maildir:/var/vmail/', maildir) AS mail",
  'FROM mailbox',
  "WHERE username = '%u' AND active = '1'"
]

node.default['dovecot']['conf']['sql']['iterate_query'] = [
  'SELECT username AS user',
  "FROM mailbox WHERE active = '1'"
]

include_recipe 'dovecot'

# Compile sieve scripts

# this should go after installing dovecot, sievec is required
sieve_global_path = "#{node['dovecot']['conf_path']}/sieve/default.sieve"
execute 'sievec sieve_global_path' do
  command "sievec '#{sieve_global_path}'"
  action :nothing
end
directory ::File.dirname(sieve_global_path) do
  owner 'root'
  group 'root'
  mode '00755'
  recursive true
  not_if { ::File.exist?(::File.dirname(sieve_global_path)) }
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

If you want a more complete example, you can look at the [postfix-dovecot](https://github.com/zuazo/postfix-dovecot-cookbook) recipe.

Testing
=======

See [TESTING.md](https://github.com/zuazo/dovecot-cookbook/blob/master/TESTING.md).

Contributing
============

Please do not hesitate to [open an issue](https://github.com/zuazo/dovecot-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/zuazo/dovecot-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/zuazo/dovecot-cookbook/blob/master/TODO.md).

License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (<xabier@zuazo.org>)
| **Contributor:**     | [Andreas Lappe](https://github.com/alappe)
| **Contributor:**     | [Trond Arve Nordheim](https://github.com/tanordheim)
| **Contributor:**     | [Johan Svensson](https://github.com/loxley)
| **Contributor:**     | [Arnold Krille](https://github.com/kampfschlaefer)
| **Contributor:**     | [claudex](https://github.com/claudex)
| **Contributor:**     | [Jordi Llonch](https://github.com/llonchj)
| **Contributor:**     | [Michael Burns](https://github.com/mburns)
| **Contributor:**     | [Marcus Klein](https://github.com/kleini)
| **Contributor:**     | [Vassilis Aretakis](https://github.com/billiaz)
| **Copyright:**       | Copyright (c) 2015-2016, Xabier de Zuazo
| **Copyright:**       | Copyright (c) 2013-2015, Onddo Labs, SL.
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
