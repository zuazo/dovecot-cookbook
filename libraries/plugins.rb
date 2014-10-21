# encoding: UTF-8

module Dovecot
  # Helper module to check required plugins
  module Plugins
    def self.require_plugin?(plugin, conf)
      conf.key?('mail_plugins') &&
      conf['mail_plugins'].include?(plugin)
    end

    def self.required?(plugin, attrs)
      attrs = attrs.to_hash
      return true if require_plugin?(plugin, attrs['conf'])
      attrs['protocols'].sort.each do |_protocol, conf|
        return true if conf.is_a?(Hash) && require_plugin?(plugin, conf)
      end
      false
    end

    def self.list_unknown(plugins)
      known_plugins = %w(
        mail_log
        quota
        acl
        sieve
      )
      plugins.keys - known_plugins
    end
  end
end
