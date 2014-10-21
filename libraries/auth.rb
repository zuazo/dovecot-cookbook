# encoding: UTF-8

module Dovecot
  # Helpers module to check if the configuration contains a valid user or passdb
  module Auth
    def self.authdb?(type, auth)
      auth.is_a?(Hash) && auth.length > 0 &&
       (auth[type].is_a?(Hash) || auth[type].is_a?(Array))
    end

    def self.passdb?(auth)
      authdb?('passdb', auth)
    end

    def self.userdb?(auth)
      authdb?('userdb', auth)
    end
  end
end
