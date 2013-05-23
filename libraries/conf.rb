
require 'erubis'

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

    def self.service(name, conf)

      template =
'service <%= @name %> {
  <% if @conf["listeners"].kind_of?(Array)
      @conf["listeners"].each do |listener|
        listener.each do |service, values|
          service_proto = service.split(":")[0]
          service_name = service.split(":")[1]
  -%>
  <%= service_proto %>_listener <%= service_name %> {
  <%     values.each do |key, value|-%>
    <%= key %> = <%= @Dovecot_Conf.value(value) %>
  <%     end -%>
  }
  <%     end -%>
  <%   end -%>
  <% end -%>
  <% @conf.each do |key, value|
      if key != "listeners"
  -%>
  <%= key %> = <%= @Dovecot_Conf.value(value) %>
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

