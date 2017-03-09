#!/usr/bin/env bats

@test "dovecot listens in the pop3 port" {
  lsof -cdovecot -a -iTCP:pop3
}
