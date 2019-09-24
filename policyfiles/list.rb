name 'list'

default_source :supermarket

cookbook 'inspec_cron', path: '..'

run_list 'inspec_cron::targets'

default['chef_client']['config']['data_collector.server_url'] = 'https://automate.example.com/data-collector/v0/'
default['inspec_cron']['token'] = '35V9X1VO0VRSeUjukPmBsihvwXI='
default['inspec_cron']['insecure'] = true

default['inspec_cron']['targets_user'] = 'scanner'

# currently only support 1 list, a hash could be added in the future for multiple lists
default['inspec_cron']['target_list'] =   ['10.0.0.2','10.0.0.3','10.0.0.4']
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
