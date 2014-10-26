#!/usr/bin/env bats

@test "ohai gets dovecot version" {
  unset BUSSER_ROOT GEM_HOME GEM_PATH GEM_CACHE
  ohai -d /etc/chef/ohai_plugins | tr -d $'\n' | grep -q '"dovecot":\s*{\s*"version"'
}

@test "ohai prints nothing to stderr" {
  unset BUSSER_ROOT GEM_HOME GEM_PATH GEM_CACHE
  [ -z "`ohai -d /etc/chef/ohai_plugins 2>&1 > /dev/null`" ]
}
