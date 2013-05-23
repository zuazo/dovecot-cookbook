module Dovecot
  module Protocols

    def self.enabled?(proto, protos)
      protos.has_key?(proto) and protos[proto].kind_of?(Hash)
    end

    def self.list(protos)
      list = []
      protos.sort.each do |proto, conf|
        list.push(proto) if conf.kind_of?(Hash)
      end
      list
    end

  end
end
