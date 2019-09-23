name 'config'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::inspec-json'
default['inspec_cron']['server_url'] = 'https://automate.example.com/data-collector/v0/'
default['inspec_cron']['token'] = '35V9X1VO0VRSeUjukPmBsihvwXI='
default['inspec_cron']['insecure'] = true
