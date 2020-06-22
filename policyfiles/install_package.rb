name 'install_package'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::install-inspec'

default['inspec_cron']['package_source'] = '/test/inspec-4.20.10-1.el7.x86_64.rpm'
default['inspec_cron']['path'] = '/opt/inspec/bin/inspec'
