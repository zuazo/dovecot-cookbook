
require 'erubis'

module Dovecot
  module Conf

    def self.value(v, default = nil)
      if v.nil?
        default.to_s
      elsif v === true
        'yes'
      elsif v === false
        'no'
      elsif v.kind_of?(Array)
        v.join(' ')
      else
        v.to_s
      end
    end

    def self.attribute(conf, k, default = nil)
      v = conf[k]
      if v.nil?
        "##{k} = #{value(default)}"
      else
        "#{k} = #{value(v)}"
      end
    end

    def self.protocols(conf)
      Dovecot::Protocols.list(conf).join(' ')
    end

    def self.authdb(type, conf)

      template =
'<% confs = [ @conf ].flatten
    confs.each do |conf| -%>
<%=   @type %> {
  <%  conf.each do |key, value|
        unless value.nil?
  -%>
  <%=     key %> = <%= @Dovecot_Conf.value(value) %>
  <%    end
      end
    end -%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :type => type,
        :conf => conf,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

    def self.plugin(name, conf)

      template =
'plugin {
  <% @conf.each do |key, value|
       unless value.nil?
  -%>
  <%=    key %> = <%= @Dovecot_Conf.value(value) %>
  <%   end
     end -%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :conf => conf,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

    def self.namespace(ns)
      template =
'namespace <%= @ns["name"] %> {
<%   @ns.each do |key, value|
       if key != "name"
  -%>
  <%=    key %> = <%= @Dovecot_Conf.value(value) %>
  <%   end
     end
-%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :ns => ns,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

    def self.protocol(name, conf)

      template =
'protocol <%= @name %> {
  <% @conf.each do |key, value| -%>
  <%=  key %> = <%= @Dovecot_Conf.value(value) %>
  <% end -%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :name => name,
        :conf => conf,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

    def self.service(name, conf)

      template =
'service <%= @name %> {
  <% if @conf["listeners"].kind_of?(Array)
      @conf["listeners"].each do |listener|
        listener.each do |service, values|
          service_proto = service.split(":")[0]
          service_name = service.split(":")[1]
  -%>
  <%=     service_proto %>_listener <%= service_name %> {
  <%        values.each do |key, value|-%>
    <%=       key %> = <%= @Dovecot_Conf.value(value) %>
  <%        end -%>
  }
  <%     end -%>
  <%   end -%>
  <% end -%>
  <% @conf.each do |key, value|
       if key != "listeners"
  -%>
  <%=    key %> = <%= @Dovecot_Conf.value(value) %>
  <%   end -%>
  <% end -%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :name => name,
        :conf => conf,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

  end
end

