# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_20_lmtp
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2016 Xabier de Zuazo
# Copyright:: Copyright (c) 2014-2015 Onddo Labs, SL.
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

# conf.d/20-lmtp.conf

default['dovecot']['conf']['lmtp_proxy'] = nil
default['dovecot']['conf']['lmtp_save_to_detail_mailbox'] = nil
default['dovecot']['conf']['lmtp_rcpt_check_quota'] = nil
default['dovecot']['conf']['lmtp_hdr_delivery_address'] = nil
