# encoding: UTF-8

name 'dovecot_test'
maintainer 'Onddo Labs, Sl.'
maintainer_email 'team@onddo.com'
license 'Apache 2.0'
description 'Installs/Configures dovecot_test'
description 'This cookbook is used with test-kitchen to test the parent, '\
            'dovecot cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'dovecot'
