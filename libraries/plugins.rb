# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Library:: plugins
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2013-2014 Onddo Labs, SL.
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

module DovecotCookbook
  # Helper module to check required plugins
  module Plugins
    def self.require_plugin?(plugin, conf)
      conf.key?('mail_plugins') &&
        conf['mail_plugins'].include?(plugin)
    end

    def self.required?(plugin, attrs)
      attrs = attrs.to_hash
      return true if require_plugin?(plugin, attrs['conf'])
      attrs['protocols'].sort.each do |_protocol, conf|
        return true if conf.is_a?(Hash) && require_plugin?(plugin, conf)
      end
      false
    end

    def self.list_unknown(plugins)
      known_plugins = %w(
        mail_log
        quota
        acl
        sieve
      )
      plugins.keys - known_plugins
    end
  end
end
