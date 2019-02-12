name 'base'

default_source :supermarket

cookbook 'inspec-cron', path: '..'

run_list 'inspec-cron::default'

# https://docs.chef.io/data_collection_without_server.html
override['chef_client']['config']['data_collector.server_url'] = 'https://ndnd/data-collector/v0/'
override['chef_client']['config']['data_collector.token'] = '8ZzgdoqAPRWsW4XOHRiFx7Kbobk='
override['audit']['reporter'] = 'chef-automate'
override['audit']['inspec_version'] = '3.6.6'

override['audit']['profiles']['linux-patch-baseline'] = { 'url': 'https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip' }

override['inspec-cron']['cron']['minute'] = '*/5'
override['inspec-cron']['cron']['hour'] = '*'
