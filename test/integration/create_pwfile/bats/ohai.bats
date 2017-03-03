#!/usr/bin/env bats

setup() {
  PLUGINS_DIR=/tmp/kitchen/ohai/plugins
}

@test "ohai gets dovecot version" {
  unset BUSSER_ROOT GEM_HOME GEM_PATH GEM_CACHE
  ohai -d $PLUGINS_DIR | tr -d $'\n' | grep -q '"dovecot":\s*{\s*"version"'
}

@test "ohai prints nothing to stderr" {
  unset BUSSER_ROOT GEM_HOME GEM_PATH GEM_CACHE
  [ -z "`ohai -d $PLUGINS_DIR 2>&1 > /dev/null`" ]
}
