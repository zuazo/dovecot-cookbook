#!/usr/bin/env bats

@test "dovecot listens in the imap port" {
  lsof -cdovecot -a -iTCP:pop3
}


