# location of config files, reuse the attribute from the chef_client cookbook
default['inspec-cron']['conf_dir'] = if node.to_hash.dig('chef_client', 'conf_dir')
                                       node['chef_client']['conf_dir']
                                     else
                                       '/etc/chef'
                                     end
default['inspec-cron']['conf_file'] = 'inspec.json'
default['inspec-cron']['version'] = '3.7.1'
default['inspec-cron']['path'] = '/opt/inspec/bin/inspec'

# default cron times for unscheduled profiles
default['inspec-cron']['cron']['minute'] = '0'
default['inspec-cron']['cron']['hour'] = '*/12'
default['inspec-cron']['cron']['day'] = '*'
default['inspec-cron']['cron']['weekday'] = '*'
default['inspec-cron']['cron']['month'] = '*'

# manage connections to Automate
default['inspec-cron']['environment'] = '_default'
# reuse the attribute from the chef_client cookbook
default['inspec-cron']['server_url'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.server_url')
                                         node['chef_client']['config']['data_collector.server_url']
                                       end
# reuse the attribute from the chef_client cookbook
default['inspec-cron']['token'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.token')
                                    node['chef_client']['config']['data_collector.token']
                                  end
default['inspec-cron']['insecure'] = false

default['inspec-cron']['profiles'] = {}

# defaults for targets
default['inspec-cron']['targets'] = {}
# defaults are oriented around SSH
default['inspec-cron']['targets_key'] = nil
default['inspec-cron']['targets_password'] = nil
default['inspec-cron']['targets_port'] = 22
default['inspec-cron']['targets_protocol'] = 'ssh'
default['inspec-cron']['targets_sudo'] = false
default['inspec-cron']['targets_user'] = nil
