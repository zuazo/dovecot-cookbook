# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Library:: conf_templates
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'erubis'

module DovecotCookbook
  module Conf
    # Configuration structure templates
    module Templates
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
               .freeze unless defined?(Conf::Templates::AUTHDB)

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
               .freeze unless defined?(Conf::Templates::PLUGIN)

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
                  .freeze unless defined?(Conf::Templates::NAMESPACE)

      PROTOCOL = <<-EOT
protocol <%= @dovecot_conf.name(@name) %> {
  <% @conf.sort.each do |key, value| -%>
  <%=  key %> = <%= @dovecot_conf.value(value) %>
  <% end -%>
}
EOT
                 .freeze unless defined?(Conf::Templates::PROTOCOL)

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
                .freeze unless defined?(Conf::Templates::SERVICE)

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
            .freeze unless defined?(Conf::Templates::MAP)
    end
  end
end
