# location of config files, reuse the attribute from the chef_client cookbook
default['inspec-cron']['conf_dir'] = if node.to_hash.dig('chef_client', 'conf_dir')
                                       node['chef_client']['conf_dir']
                                     else
                                       '/etc/chef'
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
default['inspec-cron']['server_url'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.server_url')
                                         node['chef_client']['config']['data_collector.server_url']
                                       end
# reuse the attribute from the chef_client cookbook
default['inspec-cron']['token'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.token')
                                    node['chef_client']['config']['data_collector.token']
                                  end

# reuse the attribute from the audit cookbook
default['inspec-cron']['insecure'] = node['audit']['insecure']

default['inspec-cron']['profiles'] = {}

# defaults for targets
default['inspec-cron']['targets'] = {}
default['inspec-cron']['environment'] = '_default'
