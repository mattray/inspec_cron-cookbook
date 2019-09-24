name 'everything'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::default', 'inspec_cron::targets'

default['inspec_cron']['package_source'] = '/test/inspec-4.17.4-1.el7.x86_64.rpm'
default['inspec_cron']['path'] = '/opt/inspec/bin/inspec'
default['chef_client']['config']['data_collector.server_url'] = 'https://automate.example.com/data-collector/v0/'
default['inspec_cron']['insecure'] = true
default['inspec_cron']['targets_user'] = 'scanner'
default['chef_client']['config']['data_collector.server_url'] = 'https://automate.example.com/data-collector/v0/'
default['chef_client']['config']['data_collector.token'] = '35V9X1VO0VRSeUjukPmBsihvwXI='

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
    'password': 'testing',
    'sudo': true,
    'node_uuid': 'aaaaaaaa-3976-410f-83a1-22ab3b40638c',
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

# currently only support 1 list, a hash could be added in the future for multiple lists
default['inspec_cron']['target_list'] =   ['10.0.0.12','10.0.0.13','10.0.0.14']
default['inspec_cron']['target_settings'] = {
                                             'environment': 'legacy',
                                             'key': '/tmp/test.id_rsa',
                                             'user': 'auditor',
                                             'hour': '4'
                                            }
default['inspec_cron']['target_profiles'] = {
  'linux-patch-baseline': {
    'url': 'https://github.com/dev-sec/linux-patch-baseline/',
    'minute': '*/7',
    'hour': '*/2',
  },
  'ssh-baseline': {
    'url': 'https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz'
  },
  'uptime': {
    'url': 'https://github.com/mattray/uptime-profile'
  }
}
