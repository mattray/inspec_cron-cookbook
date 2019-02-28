# location of config files, reuse the attribute from the chef_client cookbook
if node.to_hash.dig('chef_client','conf_dir')
  default['inspec-cron']['conf_dir'] = node['chef_client']['conf_dir']
else
  default['inspec-cron']['conf_dir'] = '/etc/chef'
end

default['inspec-cron']['conf_file'] = 'inspec.json'
default['inspec-cron']['inspec']['path'] = '/opt/chef/embedded/bin/inspec'

# default cron times for unscheduled profiles
default['inspec-cron']['cron']['minute'] = '0'
default['inspec-cron']['cron']['hour'] = '*/12'
default['inspec-cron']['cron']['day'] = '*'
default['inspec-cron']['cron']['weekday'] = '*'
default['inspec-cron']['cron']['month'] = '*'

# manage connections to Automate
# reuse the attribute from the chef_client cookbook
if node.to_hash.dig('chef_client','config','data_collector.server_url')
  default['inspec-cron']['server_url'] = node['chef_client']['config']['data_collector.server_url']
else
  default['inspec-cron']['server_url'] = nil
end
# reuse the attribute from the chef_client cookbook
if node.to_hash.dig('chef_client','config','data_collector.token')
  default['inspec-cron']['token'] = node['chef_client']['config']['data_collector.token']
else
  default['inspec-cron']['token'] = nil
end

# reuse the attribute from the audit cookbook
default['inspec-cron']['insecure'] = node['audit']['insecure']

default['inspec-cron']['profiles'] = {}
