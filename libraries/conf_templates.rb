# encoding: UTF-8

require 'erubis'

module Dovecot
  module Conf
    # Configuration structure templates
    module Templates
      unless defined?(::Dovecot::Conf::Templates::AUTHDB)
        AUTHDB = <<-EOT
<% confs = @conf.is_a?(Array)? @conf : [@conf]
    confs.each do |conf| -%>
<%=   @dovecot_conf.name(@type) %> {
  <%  unless conf.key?('driver') -%>
  driver = <%=   @driver %>
  <%  end -%>
  <%  conf.sort.each do |key, value|
        unless value.nil?
  -%>
  <%=     key %> = <%= @dovecot_conf.value(value) %>
  <%    end
      end
  -%>
}
<% end -%>
EOT
      end

      unless defined?(::Dovecot::Conf::Templates::PLUGIN)
        PLUGIN = <<-EOT
plugin {
  <% @conf.sort.each do |key, value|
       unless value.nil?
  -%>
  <%=    key %> = <%= @dovecot_conf.value(value) %>
  <%   end
     end -%>
}
EOT
      end

      unless defined?(::Dovecot::Conf::Templates::NAMESPACE)
        NAMESPACE = <<-EOT
namespace <%= @dovecot_conf.name(@ns['name']) %> {
  <% if @ns['mailboxes'].is_a?(Array) || @ns['mailboxes'].is_a?(Hash)
       mailboxes =
         if @ns['mailboxes'].is_a?(Array)
           @ns['mailboxes']
         else
           [@ns['mailboxes']]
         end
       mailboxes.each do |mailbox|
         mailbox.sort.each do |key, values|
  -%>
  mailbox <%= @dovecot_conf.name(key) %> {
  <%       values.sort.each do |key, value| -%>
    <%=      key %> = <%= @dovecot_conf.value(value) %>
  <%       end -%>
  }
  <%     end -%>
  <%   end -%>
  <% end -%>
  <% @ns.sort.each do |key, value|
       next if key == 'mailboxes'
  -%>
  <%=  key %> = <%= @dovecot_conf.value(value) %>
  <% end -%>
}
EOT
      end

      unless defined?(::Dovecot::Conf::Templates::PROTOCOL)
        PROTOCOL = <<-EOT
protocol <%= @dovecot_conf.name(@name) %> {
  <% @conf.sort.each do |key, value| -%>
  <%=  key %> = <%= @dovecot_conf.value(value) %>
  <% end -%>
}
EOT
      end

      unless defined?(::Dovecot::Conf::Templates::SERVICE)
        SERVICE = <<-EOT
service <%= @dovecot_conf.name(@name) %> {
  <% if @conf['listeners'].is_a?(Array) || @conf['listeners'].is_a?(Hash)
      listeners =
        if @conf['listeners'].is_a?(Array)
          @conf['listeners']
        else
          [@conf['listeners']]
        end
      listeners.each do |listener|
        listener.sort.each do |service, values|
          service_proto = service.split(':')[0]
          service_name = service.split(':')[1]
  -%>
  <%=     service_proto %>_listener <%= @dovecot_conf.name(service_name) %> {
  <%        values.sort.each do |key, value|-%>
    <%=       key %> = <%= @dovecot_conf.value(value) %>
  <%        end -%>
  }
  <%     end -%>
  <%   end -%>
  <% end -%>
  <% @conf.sort.each do |key, value|
       next if key == 'listeners'
  -%>
  <%=  key %> = <%= @dovecot_conf.value(value) %>
  <% end -%>
}
EOT
      end

      unless defined?(::Dovecot::Conf::Templates::MAP)
        MAP = <<-EOT
map {
<%     @map.sort.each do |k, v|
         if v.is_a?(Hash)
-%>
  <%=      @dovecot_conf.name(k) %> {
<%
           v.sort.each do |k2, v2|
-%>
    <%=      k2 %> = <%= @dovecot_conf.value(v2) %>
<%         end -%>
  }
<%       else -%>
  <%=      k %> = <%= @dovecot_conf.value(v) %>
<%       end
       end
-%>
}
EOT
      end
    end
  end
end
