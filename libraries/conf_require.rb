# encoding: UTF-8

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
