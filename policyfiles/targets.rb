name 'targets'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::targets'

default['chef_client']['config']['data_collector.server_url'] = 'https://automate.example.com/data-collector/v0/'
default['inspec_cron']['token'] = '35V9X1VO0VRSeUjukPmBsihvwXI='
default['inspec_cron']['insecure'] = true

default['inspec_cron']['version'] = '3.7.1'

default['inspec_cron']['targets_user'] = 'test'

default['inspec_cron']['targets'] = {
  '10.0.0.2': {
    'key': '/tmp/test.id_rsa',
    'profiles': {
      'uptime': {
        'url': 'https://github.com/mattray/uptime-profile',
        'minute': '*/10',
      },
    },
  },
  '10.0.0.3': {
    'environment': 'foo',
    'password': 'testing',
    'sudo': true,
    'node_uuid': 'aaaaaaaa-3976-410f-83a1-22ab3b40638c',
    'token': 'vWswevpNZb7OXJ0jXF11TYxbHZE=',
    'profiles': {
      'linux-patch-baseline': {
        'url': 'https://github.com/dev-sec/linux-patch-baseline/',
      },
      'uptime': {
        'url': 'https://github.com/mattray/uptime-profile',
        'minute': '*/5',
      },
    },
  },
  '10.0.0.4': {
    'node_uuid': '11111111-2222-3333-4444-555555555555',
    'password': 'testing',
    'profiles': {
      'uptime': {
        'url': 'https://github.com/mattray/uptime-profile',
        'minute': '*/7',
      },
      'ssh-baseline': {
        'url': 'https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz',
        'minute': '*/7',
        'hour': '*/2',
      },
    },
  },
}
