# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL. (www.onddo.com)
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

module Dovecot
  module Conf
    # Helper module to force some requirements
    module Requirements
      def self.set(type, node)
        case type
        when 'imap', 'pop3', 'lmtp'
          node.set['dovecot']['protocols'][type] = Mash.new
        when 'sieve' then node.set['dovecot']['conf']['mail_plugins'] = [type]
        when 'ldap' then node.set['dovecot']['auth']['ldap'] = Mash.new(a: 1)
        when 'sqlite', 'mysql', 'pgsql'
          node.set['dovecot']['conf']['sql']['driver'] = type
        end
      end

      def self.unset(type, node)
        case type
        when 'imap', 'pop3', 'lmtp'
          node.set['dovecot']['protocols'][type] = 'disabled'
        when 'sieve' then node.set['dovecot']['conf']['mail_plugins'] = []
        when 'ldap' then node.set['dovecot']['auth']['ldap'] = 'disabled'
        when 'sqlite', 'mysql', 'pgsql'
          node.set['dovecot']['conf']['sql']['driver'] = 'disabled'
        end
      end
    end
  end
end
