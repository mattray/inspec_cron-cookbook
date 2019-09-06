# location of config files, reuse the attribute from the chef_client cookbook
default['inspec_cron']['conf_dir'] = if node.to_hash.dig('chef_client', 'conf_dir')
                                       node['chef_client']['conf_dir']
                                     else
                                       '/etc/chef'
                                     end
default['inspec_cron']['conf_file'] = 'inspec.json'
default['inspec_cron']['version'] = '3.7.1'
default['inspec_cron']['path'] = '/opt/inspec/bin/inspec'

# default cron times for unscheduled profiles
default['inspec_cron']['cron']['minute'] = '0'
default['inspec_cron']['cron']['hour'] = '*/12'
default['inspec_cron']['cron']['day'] = '*'
default['inspec_cron']['cron']['weekday'] = '*'
default['inspec_cron']['cron']['month'] = '*'

# manage connections to Automate
default['inspec_cron']['environment'] = '_default'
# reuse the attribute from the chef_client cookbook
default['inspec_cron']['server_url'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.server_url')
                                         node['chef_client']['config']['data_collector.server_url']
                                       end
# reuse the attribute from the chef_client cookbook
default['inspec_cron']['token'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.token')
                                    node['chef_client']['config']['data_collector.token']
                                  end
default['inspec_cron']['insecure'] = false

default['inspec_cron']['profiles'] = {}

# defaults for targets
default['inspec_cron']['targets'] = {}
# defaults are oriented around SSH
default['inspec_cron']['targets_key'] = nil
default['inspec_cron']['targets_password'] = nil
default['inspec_cron']['targets_port'] = 22
default['inspec_cron']['targets_protocol'] = 'ssh'
default['inspec_cron']['targets_sudo'] = false
default['inspec_cron']['targets_user'] = nil
