name 'inspec_cron'
maintainer 'Matt Ray'
maintainer_email 'matt@chef.io'
license 'Apache-2.0'
description 'Manages InSpec scans via cron.'
long_description 'Schedules InSpec scans for local or remote hosts via cron.'
version '0.5.1'
chef_version '>= 14.0'

supports 'centos'
supports 'redhat'

depends 'chef-ingredient', '~> 3.1.1'

source_url 'https://github.com/mattray/inspec_cron-cookbook'
issues_url 'https://github.com/mattray/inspec_cron-cookbook/issues'
