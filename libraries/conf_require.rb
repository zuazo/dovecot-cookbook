# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Library:: conf_require
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL.
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

require 'erubis'

module DovecotCookbook
  module Conf
    # Helper module to check configuration requirements
    module Require
      def self.protocol?(proto, gconf)
        DovecotCookbook::Protocols.enabled?(proto, gconf['protocols'])
      end

      def self.plugin?(plugin, gconf)
        DovecotCookbook::Plugins.required?(plugin, gconf)
      end

      def self.ldap?(conf)
        [true, false].include?(conf['ldap']['auth_bind'])
      end

      def self.db?(db, conf)
        conf['sql']['driver'] == db
      end
    end
  end
end
