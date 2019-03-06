name 'default'

default_source :supermarket

cookbook 'inspec-cron', path: '..'

run_list 'chef-client::config', 'inspec-cron::default'

default['chef_client']['config']['data_collector.server_url'] = 'https://ndnd/data-collector/v0/'
default['chef_client']['config']['data_collector.token'] = '8ZzgdoqAPRWsW4XOHRiFx7Kbobk='

default['inspec-cron']['version'] = '3.7.1'

default['inspec-cron']['profiles'] = {
  'linux-patch-baseline': {
    'url': 'https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip',
    'minute': '15',
    'hour': '*/6',
  },
  'ssh-baseline': {
    'url': 'https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz',
    'minute': '45',
  },
  'uptime': {
    'url': 'https://github.com/mattray/uptime-profile',
  },
}

default['inspec-cron']['cron']['hour'] = '*/4'
default['inspec-cron']['insecure'] = true
