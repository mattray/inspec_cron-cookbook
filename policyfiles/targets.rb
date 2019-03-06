name 'targets'

default_source :supermarket

cookbook 'inspec-cron', path: '..'

run_list 'inspec-cron::targets'

default['inspec-cron']['server_url'] = 'https://ndnd/data-collector/v0/'
default['inspec-cron']['token'] = '8ZzgdoqAPRWsW4XOHRiFx7Kbobk='
default['inspec-cron']['insecure'] = true

default['inspec-cron']['version'] = '3.7.1'

default['inspec-cron']['targets_user'] = 'test'

default['inspec-cron']['targets'] = {
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
