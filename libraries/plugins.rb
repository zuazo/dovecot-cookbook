module Dovecot
  module Plugins

    def self.required?(plugin, attrs)
      return true if attrs.has_key?('mail_plugins') and attrs['mail_plugins'].include?(plugin)
      attrs['protocols'].each do |protocol, conf|
        return true if conf.has_key?('mail_plugins') and conf['mail_plugins'].include?(plugin)
      end
      false
    end

  end
end
