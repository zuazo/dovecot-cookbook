# encoding: UTF-8
#
# Cookbook Name:: dovecot
# Attributes:: conf_10_mail
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

# conf.d/10-mail.conf

default['dovecot']['conf']['mail_location'] = nil
default['dovecot']['conf']['mail_shared_explicit_inbox'] = nil
default['dovecot']['conf']['mail_uid'] = nil
default['dovecot']['conf']['mail_gid'] = nil
default['dovecot']['conf']['mail_privileged_group'] = nil
default['dovecot']['conf']['mail_access_groups'] = nil
default['dovecot']['conf']['mail_full_filesystem_access'] = nil
default['dovecot']['conf']['mail_attribute_dict'] = nil
default['dovecot']['conf']['mail_server_comment'] = nil
default['dovecot']['conf']['mail_server_admin'] = nil
default['dovecot']['conf']['mmap_disable'] = nil
default['dovecot']['conf']['dotlock_use_excl'] = nil
default['dovecot']['conf']['mail_fsync'] = nil
default['dovecot']['conf']['mail_nfs_storage'] = nil
default['dovecot']['conf']['mail_nfs_index'] = nil
default['dovecot']['conf']['lock_method'] = nil
default['dovecot']['conf']['mail_temp_dir'] = nil
default['dovecot']['conf']['first_valid_uid'] = nil
default['dovecot']['conf']['last_valid_uid'] = nil
default['dovecot']['conf']['first_valid_gid'] = nil
default['dovecot']['conf']['last_valid_gid'] = nil
default['dovecot']['conf']['mail_max_keyword_length'] = nil
default['dovecot']['conf']['valid_chroot_dirs'] = nil
default['dovecot']['conf']['mail_chroot'] = nil
default['dovecot']['conf']['auth_socket_path'] = nil
default['dovecot']['conf']['mail_plugin_dir'] = nil
default['dovecot']['conf']['mailbox_list_index'] = nil
default['dovecot']['conf']['mail_cache_min_mail_count'] = nil
default['dovecot']['conf']['mailbox_idle_check_interval'] = nil
default['dovecot']['conf']['mail_save_crlf'] = nil
default['dovecot']['conf']['mail_prefetch_count'] = nil
default['dovecot']['conf']['mail_temp_scan_interval'] = nil
default['dovecot']['conf']['maildir_stat_dirs'] = nil
default['dovecot']['conf']['maildir_copy_with_hardlinks'] = nil
default['dovecot']['conf']['maildir_very_dirty_syncs'] = nil
default['dovecot']['conf']['maildir_broken_filename_sizes'] = nil
default['dovecot']['conf']['maildir_empty_new'] = nil
default['dovecot']['conf']['mbox_read_locks'] = nil
default['dovecot']['conf']['mbox_write_locks'] = nil
default['dovecot']['conf']['mbox_lock_timeout'] = nil
default['dovecot']['conf']['mbox_dotlock_change_timeout'] = nil
default['dovecot']['conf']['mbox_dirty_syncs'] = nil
default['dovecot']['conf']['mbox_very_dirty_syncs'] = nil
default['dovecot']['conf']['mbox_lazy_writes'] = nil
default['dovecot']['conf']['mbox_min_index_size'] = nil
default['dovecot']['conf']['mbox_md5'] = nil
default['dovecot']['conf']['mdbox_rotate_size'] = nil
default['dovecot']['conf']['mdbox_rotate_interval'] = nil
default['dovecot']['conf']['mdbox_preallocate_space'] = nil
default['dovecot']['conf']['mail_attachment_min_size'] = nil
default['dovecot']['conf']['mail_attachment_fs'] = nil
default['dovecot']['conf']['mail_attachment_hash'] = nil
