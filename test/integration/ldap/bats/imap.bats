#!/usr/bin/env bats

@test "dovecot listens in the imap port" {
  lsof -cdovecot -a -iTCP:imap2
}

@test "dovecot listens in the imaps port" {
  lsof -cdovecot -a -iTCP:imaps
}

