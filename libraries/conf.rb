
module Dovecot
  module Conf

    def self.value(v)
      if v.kind_of?(TrueClass)
        'yes'
      elsif v.kind_of?(FalseClass)
        'no'
      elsif v.kind_of?(Array)
        v.join(' ')
      else
        v.to_s
      end
    end

  end
end

