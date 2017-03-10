# Change Log
All notable changes to the `dovecot` cookbook will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [3.2.1] - 2017-03-10
### Fixed
- Unit Tests fix: Replace Ubuntu `13.10` with Ubuntu `14.04`.

## [3.2.0] - 2017-03-10
Special thanks to [Vassilis Aretakis](https://github.com/billiaz) for his astonishing contributions :sparkles:

### Added
- Add pwfilesupport ([issue #25](https://github.com/zuazo/dovecot-cookbook/pull/25), thanks to [Vassilis Aretakis](https://github.com/billiaz), [Sjoerd Tromp](https://github.com/stromp) and [Sander van Harmelen](https://github.com/svanharmelen)).
- metadata: Add `chef_version`.
- README: Add rubydoc and inch-ci badges.

### Changed
- CHANGELOG: Follow "Keep a CHANGELOG".

## [3.1.0] - 2017-02-27
### Added
- Service: Add support for Dovecot Replication ([issue #24](https://github.com/zuazo/dovecot-cookbook/pull/24), thanks [Vassilis Aretakis](https://github.com/billiaz)).

### Changed
- Change libraries namespace from `Dovecot` to `DovecotCookbook`.

## [3.0.0] - 2016-10-09
### Added
- Add support for services: quota-status, quota-warning, doveadm ([issue #18](https://github.com/zuazo/dovecot-cookbook/pull/18), thanks [Edgaras Lukosevicius](https://github.com/ledgr)).
- Change dovecot users homedir separate attribute ([issue #21](https://github.com/zuazo/dovecot-cookbook/pull/21), thanks [Edgaras Lukosevicius](https://github.com/ledgr)).
- Update all configuration files to Dovecot `2.2.23`.
- Rewrite Ohai plugin to support Ohai cookbook version `4` ([issue #23](https://github.com/zuazo/dovecot-cookbook/pull/23), thanks [Edgaras Lukosevicius](https://github.com/ledgr)).
- README: Add license badge and improve the badges position.

### Changed
- Improve TESTING documentation.

### Fixed
- Ubuntu >= `15.10` support.
- Always create dovenull user.
- Ohai plugin: Use `#shell_out` instead of `run_command` (fix Ohai `9` support).
- Fix metadata error in a *calculated* field documentation.
- Fix RuboCop offenses in ohai plugins.

### Removed
- Drop Chef `11` support (required by ohai dependency).
- Drop Ruby `< 2.2` support.

## [2.5.0] - 2016-07-28
### Changed
* metadata: Add ohai dependency version constraint for version `3` (fixes [#22](https://github.com/zuazo/dovecot-cookbook/issues/22), thanks [Markus Wagner](https://github.com/zuazo/dovecot-cookbook/issues/22) for reporting).

## [2.4.0] - 2015-09-11
### Added
- SUSE and OpenSUSE support ([issue #16](https://github.com/zuazo/dovecot-cookbook/issues/16), thanks [Marcus Klein](https://github.com/kleini) for the help).
- Oracle Linux support.
- Scientific Linux support.

### Fixed
- Ubuntu `15.04` support.

## [2.3.0] - 2015-08-30
### Added
- metadata: Add `source_url` and `issues_url`.

### Changed
- Update chef links to use *chef.io* domain.
- Update contact information and links after migration.
- README: Improve description.

## [2.2.2] - 2015-07-29
### Changed
- README:
  - Use markdown tables.
  - Add GitHub source badge.

## [2.2.1] - 2015-07-23
### Fixed
- Travis CI: Fix `test-kitchen` integration tests.

## [2.2.0] - 2015-07-22
### Fixed
- Fix Debian Jessie support ([issue #15](https://github.com/zuazo/dovecot-cookbook/issues/15), thanks [Marcus Klein](https://github.com/kleini) for the help).

### Changed
- README: Improve examples and some fixes.

## [2.1.0] - 2015-04-04
### Changed
- Update all configuration files to Dovecot `2.2.16`.
- Update RuboCop to `0.29.1` (new offenses fixed).
- README: Add a TOC.
- Update Chef links to point to *chef.io*.

### Fixed
- Improve LDAP support, including integration tests ([issue #12](https://github.com/zuazo/dovecot-cookbook/issues/12), thanks [Dr. Ogg](https://github.com/neallawson) for reporting).

## [2.0.0] - 2014-10-28
### Changed
- Delete existing configuration files if they are not required.
- Use the `conf_files_user` attribute for configuration file directories owner instead of a hardcoded `'root'`.
- Some libraries refactored.
- `Dovecot::Auth`: remove code duplication.
- Homogenize license headers.
- README improvements.

### Removed
- Drop Ruby `< 1.9.3` support.
- Remove deprecated `::package` recipe.

### Fixed
- Fix ohai `7` plugin *"`provides` unsupported operation"* warning.
- Fix all RuboCop and Foodcritic offenses.

## [1.0.1] - 2014-10-01
### Added
- README: Added Cookbook badge.
- Added TODO file.

### Fixed
- Ubuntu `14.04` support.

## [1.0.0] - 2014-04-23
### Added
- `from_package` recipe ([issue #8](https://github.com/zuazo/dovecot-cookbook/pull/8), thanks [Jordi Llonch](https://github.com/llonchj)).
- Ohai 7 plugins support ([issue #10](https://github.com/zuazo/dovecot-cookbook/pull/10)).

### Changed
- Package installation and template generation logic standardized using a `Dovecot::Conf#require?` method ([issue #9](https://github.com/zuazo/dovecot-cookbook/pull/9), thanks [Jordi Llonch](https://github.com/llonchj) for the help).
  - ***Note:*** This change is ***huge***, but it is supposed to be backwards compatible.

### Deprecated
- `packages` recipe marked for future deprecation ([issue #8](https://github.com/zuazo/dovecot-cookbook/pull/8), thanks [Jordi Llonch](https://github.com/llonchj)).

### Fixed
- README: fixed some typos ([issue #7](https://github.com/zuazo/dovecot-cookbook/pull/7), thanks [Jordi Llonch](https://github.com/llonchj)).

## [0.3.1] - 2014-03-15
### Changed
- README: some env variables description improved.

### Fixed
- Fixed Ubuntu `13.10` support.

## [0.3.0] - 2014-03-13
### Added
- Dovecot Ohai Plugin.
- Tested to work on Fedora 18, Fedora 19 and Amazon.
- Add support for anvil service ([issue #5](https://github.com/zuazo/dovecot-cookbook/pull/5), thanks [Johan Svensson](https://github.com/loxley)).

### Changed
- Protect sensitive config files from read ([issue #4](https://github.com/zuazo/dovecot-cookbook/pull/4), thanks [claudex](https://github.com/claudex)).

### Fixed
- Auth-definitions below ldap are a hash, not an array ([issue #6](https://github.com/zuazo/dovecot-cookbook/pull/6), thanks [Arnold Krille](https://github.com/kampfschlaefer)).

## [0.2.0] - 2013-10-28
### Added
- Dict auth support and mailbox_list_index ([issue #3](https://github.com/zuazo/dovecot-cookbook/pull/3), thanks [Johan Svensson](https://github.com/loxley)).

## [0.1.1] - 2013-07-19
### Fixed
- Typo in auth-passwdfile.conf template ([issue #2](https://github.com/zuazo/dovecot-cookbook/pull/2), thanks [Trond Arve Nordheim](https://github.com/tanordheim)).
- Fix typo in README.md ([issue #1](https://github.com/zuazo/dovecot-cookbook/pull/1), thanks [Andreas Lappe](https://github.com/alappe)).

## 0.1.0 - 2013-06-08
- Initial release of `dovecot`.

[Unreleased]: https://github.com/zuazo/dovecot-cookbook/compare/3.2.1...HEAD
[3.2.1]: https://github.com/zuazo/dovecot-cookbook/compare/3.2.0...3.2.1
[3.2.0]: https://github.com/zuazo/dovecot-cookbook/compare/3.1.0...3.2.0
[3.1.0]: https://github.com/zuazo/dovecot-cookbook/compare/3.0.0...3.1.0
[3.0.0]: https://github.com/zuazo/dovecot-cookbook/compare/2.5.0...3.0.0
[2.5.0]: https://github.com/zuazo/dovecot-cookbook/compare/2.4.0...2.5.0
[2.4.0]: https://github.com/zuazo/dovecot-cookbook/compare/2.3.0...2.4.0
[2.3.0]: https://github.com/zuazo/dovecot-cookbook/compare/2.2.2...2.3.0
[2.2.2]: https://github.com/zuazo/dovecot-cookbook/compare/2.2.1...2.2.2
[2.2.1]: https://github.com/zuazo/dovecot-cookbook/compare/2.2.0...2.2.1
[2.2.0]: https://github.com/zuazo/dovecot-cookbook/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/zuazo/dovecot-cookbook/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/zuazo/dovecot-cookbook/compare/1.0.1...2.0.0
[1.0.1]: https://github.com/zuazo/dovecot-cookbook/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/zuazo/dovecot-cookbook/compare/0.3.1...1.0.0
[0.3.1]: https://github.com/zuazo/dovecot-cookbook/compare/0.3.0...0.3.1
[0.3.0]: https://github.com/zuazo/dovecot-cookbook/compare/0.2.0...0.3.0
[0.2.0]: https://github.com/zuazo/dovecot-cookbook/compare/0.1.1...0.2.0
[0.1.1]: https://github.com/zuazo/dovecot-cookbook/compare/0.1.0...0.1.1
