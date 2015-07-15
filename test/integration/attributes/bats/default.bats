#!/usr/bin/env bats

@test "doveconf runs without errors" {
  doveconf > /dev/null
}

@test "ordinary files has the correct mode" {
  ! stat -c '%a' /etc/dovecot/*.conf.ext | grep -v -qwF 640
}

@test "sensitive files has restricted mode" {
  ! stat -c '%a' /etc/dovecot/conf.d/* | grep -v -qwF 644
}

