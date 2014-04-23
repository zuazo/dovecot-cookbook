# CHANGELOG for dovecot

This file is used to list changes made in each version of dovecot.

## 1.0.0:

* `kitchen.cloud.yml`:
 * Use `t1.micro-ebs` instances on EC2
 * Use 512MB instances on DigitalOcean
 * `require_chef_omnibus` `true` instead of `latest`
 * Some images updated
* README: fixed some typos ([issue #7](https://github.com/onddo/dovecot-cookbook/pull/7), thanks [Jordi Llonch](https://github.com/llonchj))
* Added `from_package` recipe, `packages` recipe marked for future deprecation ([issue #8](https://github.com/onddo/dovecot-cookbook/pull/8), thanks [Jordi Llonch](https://github.com/llonchj))
* Added integration tests for IMAP protocol
* Package installation and template generation logic standardized using a `Dovecot::Conf#require?` method ([issue #9](https://github.com/onddo/dovecot-cookbook/pull/9), thanks [Jordi Llonch](https://github.com/llonchj) for the help)
 * ***Note:*** This change is ***huge***, but it is supposed to be backwards compatible
* Added Ohai 7 plugins support ([issue #10](https://github.com/onddo/dovecot-cookbook/pull/10))

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

