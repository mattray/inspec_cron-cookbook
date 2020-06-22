name 'install_chef'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::install-inspec'

default['inspec_cron']['version'] = '4.20.10'
default['inspec_cron']['path'] = '/opt/inspec/bin/inspec'
