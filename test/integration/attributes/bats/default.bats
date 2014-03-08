#!/usr/bin/env bats

@test "dovecot should be running" {
  ps axu | grep -q 'doveco[t]'
}

@test "doveconf should run without errors" {
  doveconf > /dev/null
}

@test "ordinary files should have the correct mode" {
  ! stat -c '%a' /etc/dovecot/*.conf.ext | grep -v -qwF 640
}

@test "sensitive files should have restricted mode" {
  ! stat -c '%a' /etc/dovecot/conf.d/* | grep -v -qwF 644
}

