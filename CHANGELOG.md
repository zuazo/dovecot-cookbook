# CHANGELOG for dovecot

This file is used to list changes made in each version of dovecot.

## 0.3.1:

* Fixed Ubuntu-13.10 support
* README: some env variables description improved
* Avoid using EC2_SSH_KEY_PATH when there is an SSH Agent
* kitchen.yml format updated, removed driver_config key

## 0.3.0:

* Added Dovecot Ohai Plugin
* kitchen.yml: vagrant boxes updated
* Gemfile: some dependency versions updated
* Tested to work on Fedora 18, Fedora 19 and Amazon
* Add support for anvil service ([issue #5](https://github.com/onddo/dovecot-cookbook/pull/5), thanks [Johan Svensson](https://github.com/loxley))
* Auth-definitions below ldap are a hash, not an array ([issue #6](https://github.com/onddo/dovecot-cookbook/pull/6), thanks [Arnold Krille](https://github.com/kampfschlaefer))
* Protect sensitive config files from read ([issue #4](https://github.com/onddo/dovecot-cookbook/pull/4), thanks [claudex](https://github.com/claudex))

## 0.2.0:

* Dict auth support and mailbox_list_index ([issue #3](https://github.com/onddo/dovecot-cookbook/pull/3), thanks [Johan Svensson](https://github.com/loxley))

## 0.1.1:

* Typo in auth-passwdfile.conf template ([issue #2](https://github.com/onddo/dovecot-cookbook/pull/2), thanks [Trond Arve Nordheim](https://github.com/tanordheim))
* Fix typo in README.md ([issue #1](https://github.com/onddo/dovecot-cookbook/pull/1), thanks [Andreas Lappe](https://github.com/alappe)) 
* Gemfile improvements

## 0.1.0:

* Initial release of `dovecot`

