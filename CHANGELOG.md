# CHANGELOG for dovecot

This file is used to list changes made in each version of `dovecot` cookbook.

## v3.0.0 (2016-10-09)

### Breaking Changes on v3.0.0

* Drop Chef `11` support (required by ohai dependency).
* Drop Ruby `< 2.2` support.

### New Features on v3.0.0

* Add support for services: quota-status, quota-warning, doveadm ([issue #18](https://github.com/zuazo/dovecot-cookbook/pull/18), thanks [@ledgr](https://github.com/ledgr)).
* Change dovecot users homedir separate attribute ([issue #21](https://github.com/zuazo/dovecot-cookbook/pull/21), thanks [@ledgr](https://github.com/ledgr)).
* Update all configuration files to Dovecot `2.2.23`.
* Rewrite Ohai plugin to support Ohai cookbook version `4` ([issue #23](https://github.com/zuazo/dovecot-cookbook/pull/23), thanks [@ledgr](https://github.com/ledgr)).

### Fixes on v3.0.0

* Fix Ubuntu >= `15.10` support.
* Always create dovenull user.
* Ohai plugin: Use `#shell_out` instead of `run_command` (fix Ohai `9` support).
* Fix metadata error in a *calculated* field documentation.

### Improvements on v3.0.0

* Fix RuboCop offenses in ohai plugins.

### Documentation Changes on v3.0.0

* README: Add license badge and improve the badges position.
* Improve TESTING documentation.

### Changes on Tests on v3.0.0

* test-kitchen: Update platform versions.
* Travis CI:
  * Run test-kitchen using native Docker support.
  * Improve ChefDK installation procedure.
  * Update ChefDK to version `0.18.3`.
  * Run unit tests against Ruby `2.3` also.
* Update all gems in the Gemfile.
  * Update kitchen-digitalocean, fix *Resolving dependencies*.

## v2.5.0 (2016-07-28)

* metadata: Add ohai dependency version constraint for version `3` (fixes [#22](https://github.com/zuazo/dovecot-cookbook/issues/22), thanks [Markus Wagner](https://github.com/zuazo/dovecot-cookbook/issues/22) for reporting).
* Fix the unit and integration tests.

## v2.4.0 (2015-09-11)

* Improve platforms support using `node['platform_family']`:
 * Fix Ubuntu `15.04` support.
 * Add SUSE and OpenSUSE support ([issue #16](https://github.com/zuazo/dovecot-cookbook/issues/16), thanks [Marcus Klein](https://github.com/kleini) for the help).
 * Add Oracle Linux support.
 * Add Scientific Linux support.

* Testing:
 * Vagrantfile: Add Chef Server documentation.
 * Gemfile: foodcritic ~> `4.0.0`, rubocop ~> `0.34.0`.
 * Rakefile: Add arguments to the integration task.

## v2.3.0 (2015-08-30)

* Update chef links to use *chef.io* domain.
* Update contact information and links after migration.
* metadata: Add `source_url` and `issues_url`.

* Tests:
 * Move ChefSpec tests to *test/unit*.
 * Rakefile: Add clean task.
 * Travis CI: Use `kitchen-in-travis` version `0.3.0`.
 * Gemfile: Update RuboCop to `0.33.0`.

* Documentation:
 * README: Improve description.

## v2.2.2 (2015-07-29)

* Documentation:
 * README: Use markdown tables.
 * Add GitHub source badge.

* Tests:
 * Gemfile: kitchen-docker `~> 2.1.0`.

## v2.2.1 (2015-07-23)

* Travis CI: Fix `test-kitchen` integration tests.

## v2.2.0 (2015-07-22)

* Fix Debian Jessie support ([issue #15](https://github.com/zuazo/dovecot-cookbook/issues/15), thanks [Marcus Klein](https://github.com/kleini) for the help).

* Tests:
 * Fix typo in 'dovecot is running' test ([issue #13](https://github.com/zuazo/dovecot-cookbook/pull/13), thanks [Michael Burns](https://github.com/mburns)).
 * Integrate [Kitchen integration tests in Travis CI](https://github.com/zuazo/kitchen-in-travis).
 * Gemfile: Update RuboCop to `0.32.1`.
 * Run Travis CI tests in Ruby `2.2`.
 * Temporary disable `guard-kitchen`.

* Documentation:
 * README: Improve examples and some fixes.

## v2.1.0 (2015-04-04)

* Improve LDAP support, including integration tests ([issue #12](https://github.com/zuazo/dovecot-cookbook/issues/12), thanks [Dr. Ogg](https://github.com/neallawson) for reporting).
* Update all configuration files to Dovecot `2.2.16`.
* Update RuboCop to `0.29.1` (new offenses fixed).

* Tests:
 * Update kitchen.yml file.
 * Some small unit tests fixes.
 * Integration tests fix: disable director port binding in CentOS due to SELinux.
 * Complete the unit test coverage (100%).
 * Integrate tests with coveralls.io and simplecov.
 * Gemfile:
  * Use foodcritic and RuboCop fixed versions.
  * Update vagrant-wrapper to version `2`.
  * Add ohai `< 8` for ruby `< 2`.
 * travis.yml: Use the new build environment.

* Documentation:
 * README: Add a TOC.
 * Update Chef links to point to *chef.io*.

## v2.0.0 (2014-10-28)

* Requires Ruby `>= 1.9.3` (**breaking change**).
* Remove deprecated `::package` recipe (**breaking change**).
* Delete existing configuration files if they are not required.
* Use the `conf_files_user` attribute for configuration file directories owner instead of a hardcoded `'root'`.
* Fix ohai `7` plugin *"`provides` unsupported operation"* warning.
* Some libraries refactored.
* `Dovecot::Auth`: remove code duplication.
* Fix all RuboCop and Foodcritic offenses.
* Add ChefSpec tests.
* Add Serverspec tests.
* Tests integrated with `should_not` gem.
* Remove *shoulds* from integration tests.
* Add some template files: Berksfile, Gemfile, Guardfile and spec_helper.
* Update kitchen.yml files.
* kitchen.yml: add forwarded ports.
* Move *test/kitchen/cookbooks* to *test/cookbooks*.
* Gemfile:
 * Use Berkshelf `3.1`.
 * Use `vagrant-wrapper` gem.
* Vagrantfile refactored and updated to work.
* Add travis.yml file.
* Homogenize license headers.
* README:
 * Fix `install_from` attribute description.
 * Badges: gemnasium, codeclimate and travis-ci.
 * Use shields.io for cookbook badge.
 * Split README file into multiple files.
 * Fix some titles capitalization.
 * Some small documentation improvements.
 * put `>=` between code quotes.
* Add LICENSE file.

## v1.0.1 (2014-10-01)

* README: Added Cookbook badge
* Fixed Ubuntu 14.04 support
* Added TODO file

## v1.0.0 (2014-04-23)

* `kitchen.cloud.yml`:
 * Use `t1.micro-ebs` instances on EC2
 * Use 512MB instances on DigitalOcean
 * `require_chef_omnibus` `true` instead of `latest`
 * Some images updated
* README: fixed some typos ([issue #7](https://github.com/zuazo/dovecot-cookbook/pull/7), thanks [Jordi Llonch](https://github.com/llonchj))
* Added `from_package` recipe, `packages` recipe marked for future deprecation ([issue #8](https://github.com/zuazo/dovecot-cookbook/pull/8), thanks [Jordi Llonch](https://github.com/llonchj))
* Added integration tests for IMAP protocol
* Package installation and template generation logic standardized using a `Dovecot::Conf#require?` method ([issue #9](https://github.com/zuazo/dovecot-cookbook/pull/9), thanks [Jordi Llonch](https://github.com/llonchj) for the help)
 * ***Note:*** This change is ***huge***, but it is supposed to be backwards compatible
* Added Ohai 7 plugins support ([issue #10](https://github.com/zuazo/dovecot-cookbook/pull/10))

## v0.3.1 (2014-03-15)

* Fixed Ubuntu-13.10 support
* README: some env variables description improved
* Avoid using EC2_SSH_KEY_PATH when there is an SSH Agent
* kitchen.yml format updated, removed driver_config key

## v0.3.0 (2014-03-13)

* Added Dovecot Ohai Plugin
* kitchen.yml: vagrant boxes updated
* Gemfile: some dependency versions updated
* Tested to work on Fedora 18, Fedora 19 and Amazon
* Add support for anvil service ([issue #5](https://github.com/zuazo/dovecot-cookbook/pull/5), thanks [Johan Svensson](https://github.com/loxley))
* Auth-definitions below ldap are a hash, not an array ([issue #6](https://github.com/zuazo/dovecot-cookbook/pull/6), thanks [Arnold Krille](https://github.com/kampfschlaefer))
* Protect sensitive config files from read ([issue #4](https://github.com/zuazo/dovecot-cookbook/pull/4), thanks [claudex](https://github.com/claudex))

## v0.2.0 (2013-10-28)

* Dict auth support and mailbox_list_index ([issue #3](https://github.com/zuazo/dovecot-cookbook/pull/3), thanks [Johan Svensson](https://github.com/loxley))

## v0.1.1 (2013-07-19)

* Typo in auth-passwdfile.conf template ([issue #2](https://github.com/zuazo/dovecot-cookbook/pull/2), thanks [Trond Arve Nordheim](https://github.com/tanordheim))
* Fix typo in README.md ([issue #1](https://github.com/zuazo/dovecot-cookbook/pull/1), thanks [Andreas Lappe](https://github.com/alappe))
* Gemfile improvements

## v0.1.0 (2013-06-08)

* Initial release of `dovecot`
