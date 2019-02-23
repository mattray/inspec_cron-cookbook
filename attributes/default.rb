# location of config files
default['inspec-cron']['conf_dir'] = '/etc/chef'
default['inspec-cron']['conf_file'] = 'inspec.json'
default['inspec-cron']['inspec']['path'] = '/opt/chef/embedded/bin/inspec'

# default cron times for unscheduled profiles
default['inspec-cron']['cron']['minute'] = '0'
default['inspec-cron']['cron']['hour'] = '*/12'
default['inspec-cron']['cron']['day'] = '*'
default['inspec-cron']['cron']['weekday'] = '*'
default['inspec-cron']['cron']['month'] = '*'

# seconds to wait between executing cron jobs
default['inspec-cron']['splay'] = 0

# manage connections to Automate
default['inspec-cron']['server_url'] = nil
default['inspec-cron']['token'] = nil
default['inspec-cron']['insecure'] = false

default['inspec-cron']['profiles'] = {}
