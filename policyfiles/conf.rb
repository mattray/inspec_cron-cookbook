name 'config'

default_source :supermarket

cookbook 'inspec-cron', path: '..'

run_list 'inspec-cron::inspec-json'

default['inspec-cron']['conf_dir'] = '/tmp/inspec'
default['inspec-cron']['server_url'] = 'https://ndnd/data-collector/v0/'
default['inspec-cron']['token'] = '8ZzgdoqAPRWsW4XOHRiFx7Kbobk='
default['inspec-cron']['insecure'] = true
