#!/usr/bin/env bats

@test "dovecot listens on the imap port" {
  lsof -cdovecot -a -iTCP:143
}

@test "dovecot listens on the imaps port" {
  lsof -cdovecot -a -iTCP:993
}
