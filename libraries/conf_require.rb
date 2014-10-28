# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Library:: conf_require
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

require 'erubis'

module Dovecot
  module Conf
    # Helper module to check configuration requirements
    module Require
      def self.protocol?(proto, conf)
        Dovecot::Protocols.enabled?(proto, conf['protocols'])
      end

      def self.plugin?(plugin, conf)
        Dovecot::Plugins.required?(plugin, conf)
      end

      def self.ldap?(conf)
        conf['auth']['ldap'].is_a?(Hash) && conf['auth']['ldap'].length > 0
      end

      def self.db?(db, conf)
        conf['conf']['sql']['driver'] == db
      end
    end
  end
end
