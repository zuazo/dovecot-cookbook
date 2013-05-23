
module Dovecot
  module Auth

    def self.has_passdb?(auth)
      auth.kind_of?(Hash) and auth.length > 0 and
       ( auth['passdb'].kind_of?(Hash) or auth['passdb'].kind_of?(Array) )
    end

    def self.has_userdb?(auth)
      auth.kind_of?(Hash) and auth.length > 0 and
       ( auth['userdb'].kind_of?(Hash) or auth['userdb'].kind_of?(Array) )
    end

  end
end

