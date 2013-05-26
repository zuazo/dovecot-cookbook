module Dovecot
  module Plugins

    def self.required?(plugin, attrs)
      attrs = attrs.to_hash
      return true if attrs['conf'].has_key?('mail_plugins') and attrs['conf']['mail_plugins'].include?(plugin)
      attrs['protocols'].sort.each do |protocol, conf|
        return true if conf.kind_of?(Hash) and conf.has_key?('mail_plugins') and conf['mail_plugins'].include?(plugin)
      end
      false
    end

    def self.list_unknown(plugins)
      known_plugins = [
        'mail_log',
        'quota',
        'acl',
        'sieve'
      ]

      plugins.keys - known_plugins
    end

  end
end
