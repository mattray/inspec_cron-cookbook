name 'default'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'chef-client::config', 'inspec_cron::default'

default['chef_client']['config']['data_collector.server_url'] = 'https://automate.example.com/data-collector/v0/'
default['chef_client']['config']['data_collector.token'] = '8ZzgdoqAPRWsW4XOHRiFx7Kbobk='

default['inspec_cron']['version'] = '3.7.1'

default['inspec_cron']['profiles'] = {
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

default['inspec_cron']['cron']['hour'] = '*/4'
default['inspec_cron']['insecure'] = true
