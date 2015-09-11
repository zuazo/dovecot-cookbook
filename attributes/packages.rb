# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: packages
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'rhel', 'fedora'
  default['dovecot']['packages']['core'] = %w(dovecot)
  default['dovecot']['packages']['imap'] = [] # included inside core
  default['dovecot']['packages']['pop3'] = [] # included inside core
  default['dovecot']['packages']['lmtp'] = [] # included inside core
  default['dovecot']['packages']['sieve'] = %w(dovecot-pigeonhole)
  default['dovecot']['packages']['ldap'] = [] # included inside core
  default['dovecot']['packages']['sqlite'] = [] # included inside core
  default['dovecot']['packages']['mysql'] = %w(dovecot-mysql)
  default['dovecot']['packages']['pgsql'] = %w(dovecot-pgsql)
when 'suse'
  default['dovecot']['packages']['core'] = %w(dovecot)
  default['dovecot']['packages']['imap'] = [] # included inside core
  default['dovecot']['packages']['pop3'] = [] # included inside core
  default['dovecot']['packages']['lmtp'] = [] # included inside core
  default['dovecot']['packages']['sieve'] = [] # included inside core
  default['dovecot']['packages']['ldap'] = [] # included inside core
  default['dovecot']['packages']['sqlite'] = %w(dovecot-backend-sqlite)
  default['dovecot']['packages']['mysql'] = %w(dovecot-backend-mysql)
  default['dovecot']['packages']['pgsql'] = %w(dovecot-backend-pgsql)
when 'arch' # not tested
  default['dovecot']['packages']['core'] = %w(dovecot)
  default['dovecot']['packages']['imap'] = [] # included inside core
  default['dovecot']['packages']['pop3'] = [] # included inside core
  default['dovecot']['packages']['lmtp'] = [] # included inside core
  default['dovecot']['packages']['sieve'] = %w(pigeonhole)
  default['dovecot']['packages']['ldap'] = [] # included inside core
  default['dovecot']['packages']['sqlite'] = [] # included inside core
  default['dovecot']['packages']['mysql'] = [] # included inside core
  default['dovecot']['packages']['pgsql'] = [] # included inside core
else # when 'debian'
  default['dovecot']['packages']['core'] = %w(dovecot-core dovecot-gssapi)
  default['dovecot']['packages']['imap'] = %w(dovecot-imapd)
  default['dovecot']['packages']['pop3'] = %w(dovecot-pop3d)
  default['dovecot']['packages']['lmtp'] = %w(dovecot-lmtpd)
  default['dovecot']['packages']['sieve'] =
    %w(dovecot-sieve dovecot-managesieved)
  default['dovecot']['packages']['ldap'] = %w(dovecot-ldap)
  default['dovecot']['packages']['sqlite'] = %w(dovecot-sqlite)
  default['dovecot']['packages']['mysql'] = %w(dovecot-mysql)
  default['dovecot']['packages']['pgsql'] = %w(dovecot-pgsql)
end
