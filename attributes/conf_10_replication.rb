# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_replication
# Author:: Vassilis Aretakis (<vassilis@aretakis.eu>)
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

# conf.d/10-director.conf

default['dovecot']['conf']['doveadm_port'] = nil
default['dovecot']['conf']['doveadm_password'] = nil
