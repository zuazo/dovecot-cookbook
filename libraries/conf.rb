# encoding: UTF-8

require 'erubis'

module Dovecot
  # Helper module to generate configuration structures
  module Conf
    def self.name(str)
      str =~ /\s/ ? "\"#{str}\"" : str
    end

    def self.value(v, default = nil)
      case v
      when nil then default.to_s
      when true then 'yes'
      when false then 'no'
      when Array then v.join(' ')
      else
        v.to_s
      end
    end

    def self.attribute(conf, k, default = nil)
      v = conf[k]
      v.nil? ? "##{k} = #{value(default)}" : "#{k} = #{value(v)}"
    end

    def self.evaluate_template(template, context)
      context = context.merge(dovecot_conf: Dovecot::Conf)
      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(context)
    end

    def self.protocols(conf)
      # dovecot: config: Fatal: Error in configuration file
      # /etc/dovecot/dovecot.conf: protocols: Unknown protocol: lda
      ignore_protos = %w(lda)
      protos = Dovecot::Protocols.list(conf) - ignore_protos
      protos.empty? ? 'none' : protos.join(' ')
    end

    def self.authdb(driver, type, conf)
      template = Dovecot::Conf::Templates::AUTHDB
      evaluate_template(template, driver: driver, type: type, conf: conf)
    end

    def self.plugin(_name, conf)
      template = Dovecot::Conf::Templates::PLUGIN
      evaluate_template(template, conf: conf)
    end

    def self.namespace(ns)
      template = Dovecot::Conf::Templates::NAMESPACE
      evaluate_template(template, ns: ns)
    end

    def self.protocol(name, conf)
      template = Dovecot::Conf::Templates::PROTOCOL
      evaluate_template(template, name: name, conf: conf)
    end

    def self.service(name, conf)
      template = Dovecot::Conf::Templates::SERVICE
      evaluate_template(template, name: name, conf: conf)
    end

    def self.map(map)
      template = Dovecot::Conf::Templates::MAP
      evaluate_template(template, map: map)
    end

    def self.require?(req, conf)
      case req
      when 'core' then true
      when 'imap', 'pop3', 'lmtp' then Conf::Require.protocol?(req, conf)
      when 'sieve' then Conf::Require.plugin?('sieve', conf)
      when 'ldap' then Conf::Require.ldap?(conf)
      when 'sqlite', 'mysql', 'pgsql' then Conf::Require.db?(req, conf)
      else
        fail "Unknown configuration requirement: #{req.inspect}"
      end
    end
  end
end
