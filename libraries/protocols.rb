# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Library:: protocols
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
  # Helper module to check enabled protocols
  module Protocols
    def self.enabled?(proto, protos)
      protos.key?(proto) && protos[proto].is_a?(Hash)
    end

    def self.list(protos)
      list = []
      protos.sort.each { |proto, conf| list.push(proto) if conf.is_a?(Hash) }
      list
    end
  end
end
