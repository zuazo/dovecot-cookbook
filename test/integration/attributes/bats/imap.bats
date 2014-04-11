#!/usr/bin/env bats

@test "dovecot should be listening in the imap port" {
  lsof -cdovecot -a -iTCP:imap2
}

@test "dovecot should be listening in the imaps port" {
  lsof -cdovecot -a -iTCP:imaps
}

