# encoding: UTF-8

module Dovecot
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
