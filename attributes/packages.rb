case node['platform']
when 'redhat', 'centos', 'scientific', 'fedora', 'suse', 'amazon', 'oracle'
  default['dovecot']['packages']['core'] = %w{dovecot}
  default['dovecot']['packages']['imap'] = [] # included inside core
  default['dovecot']['packages']['pop3'] = [] # included inside core
  default['dovecot']['packages']['lmtp'] = [] # included inside core
  default['dovecot']['packages']['sieve'] = %w{dovecot-pigeonhole}
  default['dovecot']['packages']['ldap'] = [] # included inside core
  default['dovecot']['packages']['sqlite'] = [] # included inside core
  default['dovecot']['packages']['mysql'] = %w{dovecot-mysql}
  default['dovecot']['packages']['pgsql'] = %w{dovecot-pgsql}
when 'arch' # not tested
  default['dovecot']['packages']['core'] = %w{dovecot}
  default['dovecot']['packages']['imap'] = [] # included inside core
  default['dovecot']['packages']['pop3'] = [] # included inside core
  default['dovecot']['packages']['lmtp'] = [] # included inside core
  default['dovecot']['packages']['sieve'] = %w{pigeonhole}
  default['dovecot']['packages']['ldap'] = [] # included inside core
  default['dovecot']['packages']['sqlite'] = [] # included inside core
  default['dovecot']['packages']['mysql'] = [] # included inside core
  default['dovecot']['packages']['pgsql'] = [] # included inside core
else
# when 'debian', 'ubuntu'
  default['dovecot']['packages']['core'] = %w{dovecot-core dovecot-gssapi}
  default['dovecot']['packages']['imap'] = %w{dovecot-imapd}
  default['dovecot']['packages']['pop3'] = %w{dovecot-pop3d}
  default['dovecot']['packages']['lmtp'] = %w{dovecot-lmtpd}
  default['dovecot']['packages']['sieve'] = %w{dovecot-sieve dovecot-managesieved}
  default['dovecot']['packages']['ldap'] = %w{dovecot-ldap}
  default['dovecot']['packages']['sqlite'] = %w{dovecot-sqlite}
  default['dovecot']['packages']['mysql'] = %w{dovecot-mysql}
  default['dovecot']['packages']['pgsql'] = %w{dovecot-pgsql}
end

