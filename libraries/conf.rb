
require 'erubis'

module Dovecot
  module Conf

    def self.name(str)
      if str =~ /\s/
        "\"#{str}\""
      else
        str
      end
    end

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
      # dovecot: config: Fatal: Error in configuration file /etc/dovecot/dovecot.conf: protocols: Unknown protocol: lda
      ignore_protos = [ 'lda' ]
      protos = Dovecot::Protocols.list(conf) - ignore_protos
      protos.empty? ? 'none' : protos.join(' ')
    end

    def self.authdb(driver, type, conf)

      template =
'<% confs = @conf.kind_of?(Array)? @conf : [ @conf ]
    confs.each do |conf| -%>
<%=   @Dovecot_Conf.name(@type) %> {
  <%  unless conf.has_key?("driver") -%>
  driver = <%=   @driver %>
  <%  end -%>
  <%  conf.sort.each do |key, value|
        unless value.nil?
  -%>
  <%=     key %> = <%= @Dovecot_Conf.value(value) %>
  <%    end
      end
  -%>
}
<% end -%>'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :driver => driver,
        :type => type,
        :conf => conf,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

    def self.plugin(name, conf)

      template =
'plugin {
  <% @conf.sort.each do |key, value|
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
'namespace <%= @Dovecot_Conf.name(@ns["name"]) %> {
  <% if @ns["mailboxes"].kind_of?(Array) or @ns["mailboxes"].kind_of?(Hash)
       mailboxes = @ns["mailboxes"].kind_of?(Array) ? @ns["mailboxes"] : [ @ns["mailboxes"] ]
       mailboxes.each do |mailbox|
         mailbox.sort.each do |key, values|
  -%>
  mailbox <%= @Dovecot_Conf.name(key) %> {
  <%       values.sort.each do |key, value| -%>
    <%=      key %> = <%= @Dovecot_Conf.value(value) %>
  <%       end -%>
  }
  <%     end -%>
  <%   end -%>
  <% end -%>
  <% @ns.sort.each do |key, value|
       next if key == "mailboxes"
  -%>
  <%=  key %> = <%= @Dovecot_Conf.value(value) %>
  <% end -%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :ns => ns,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

    def self.protocol(name, conf)

      template =
'protocol <%= @Dovecot_Conf.name(@name) %> {
  <% @conf.sort.each do |key, value| -%>
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
'service <%= @Dovecot_Conf.name(@name) %> {
  <% if @conf["listeners"].kind_of?(Array) or @conf["listeners"].kind_of?(Hash)
      listeners = @conf["listeners"].kind_of?(Array) ? @conf["listeners"] : [ @conf["listeners"] ]
      listeners.each do |listener|
        listener.sort.each do |service, values|
          service_proto = service.split(":")[0]
          service_name = service.split(":")[1]
  -%>
  <%=     service_proto %>_listener <%= @Dovecot_Conf.name(service_name) %> {
  <%        values.sort.each do |key, value|-%>
    <%=       key %> = <%= @Dovecot_Conf.value(value) %>
  <%        end -%>
  }
  <%     end -%>
  <%   end -%>
  <% end -%>
  <% @conf.sort.each do |key, value|
       next if key == "listeners"
  -%>
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

    def self.map(map)

    template =
'map {
<%     @map.sort.each do |k, v|
         if v.kind_of?(Hash)
-%>
  <%=      @Dovecot_Conf.name(k) %> {
<%
           v.sort.each do |k2, v2|
-%>
    <%=      k2 %> = <%= @Dovecot_Conf.value(v2) %>
<%         end -%>
  }
<%       else -%>
  <%=      k %> = <%= @Dovecot_Conf.value(v) %>
<%       end
       end
-%>
}'

      eruby = Erubis::Eruby.new(template)
      eruby.evaluate(
        :map => map,
        :Dovecot_Conf => Dovecot::Conf
      )
    end

  end
end

