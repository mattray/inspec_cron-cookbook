name 'install_chef'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::install-inspec'
