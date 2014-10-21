# encoding: UTF-8

module Dovecot
  # Helpers module to check if the configuration contains a valid user or passdb
  module Auth
    def self.passdb?(auth)
      auth.is_a?(Hash) && auth.length > 0 &&
       (auth['passdb'].is_a?(Hash) || auth['passdb'].is_a?(Array))
    end

    def self.userdb?(auth)
      auth.is_a?(Hash) && auth.length > 0 &&
       (auth['userdb'].is_a?(Hash) || auth['userdb'].is_a?(Array))
    end
  end
end
