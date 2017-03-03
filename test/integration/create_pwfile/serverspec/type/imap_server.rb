# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL.
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

require 'net/imap'

module Serverspec
  # Serverspec resource types.
  module Type
    # Serverspec IMAP resource type.
    class ImapServer < Base
      # TODO: Silence stderr with IMAP exceptions

      def initialize(server, port)
        @host = port.nil? ? server : "#{server}:#{port}"
        super(@host)
      end

      def to_s
        %(IMAP "imap://#{@host}")
      end

      protected

      def imap
        @imap ||= ::Net::IMAP.new(@host)
      end

      def imap_close
        return if @imap.nil?
        @imap.close
      rescue ::Net::IMAP::BadResponseError
        nil
      ensure
        @imap = nil
      end

      public

      def connects?
        imap
        imap_close
        true
      rescue ::Net::IMAP::NoResponseError
        false
      end

      def authenticates?(user, pass, auth_type)
        imap.authenticate(auth_type, user, pass)
        imap.examine('INBOX')
        imap_close
        true
      rescue ::Net::IMAP::NoResponseError
        false
      end
    end

    def imap_server(server, port = nil)
      ::Serverspec::Type::ImapServer.new(server, port)
    end
  end
end

include Serverspec::Type

RSpec::Matchers.define :connect do
  match(&:connects?)
end

RSpec::Matchers.define :authenticate do |user, pass, auth_type = 'PLAIN'|
  match do |subject|
    subject.authenticates?(user, pass, auth_type)
  end
end
