# defaults are from Chef node settings or provided by the chef_client cookbook

# INSPEC_JSON
# location of config files, reuse the attribute from the chef_client cookbook
default['inspec_cron']['conf_file'] = if node.to_hash.dig('chef_client', 'conf_dir')
                                        node['chef_client']['conf_dir'] + '/inspec.json'
                                      else
                                        '/etc/chef/inspec.json'
                                      end
default['inspec_cron']['name'] = node.name
default['inspec_cron']['uuid'] = node['chef_guid']
default['inspec_cron']['environment'] = node.chef_environment
default['inspec_cron']['insecure'] = if node.to_hash.dig('audit', 'insecure')
                                       node['audit']['insecure']
                                     else
                                       false
                                     end
default['inspec_cron']['server_url'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.server_url')
                                         node['chef_client']['config']['data_collector.server_url']
                                       end
default['inspec_cron']['token'] = if node.to_hash.dig('chef_client', 'config', 'data_collector.token')
                                    node['chef_client']['config']['data_collector.token']
                                  end

# INSPEC_CRONTAB
default['inspec_cron']['version'] = nil
default['inspec_cron']['channel'] = :stable
default['inspec_cron']['package_source'] = nil
default['inspec_cron']['path'] = '/opt/inspec/bin/inspec'

# default cron times for unscheduled profiles
default['inspec_cron']['cron']['minute'] = '0'
default['inspec_cron']['cron']['hour'] = '*/12'
default['inspec_cron']['cron']['day'] = '*'
default['inspec_cron']['cron']['weekday'] = '*'
default['inspec_cron']['cron']['month'] = '*'

default['inspec_cron']['profiles'] = {}

# defaults for targets
default['inspec_cron']['targets'] = {}
# defaults are oriented around SSH, other settings could be added
default['inspec_cron']['targets_key'] = nil
default['inspec_cron']['targets_password'] = nil
default['inspec_cron']['targets_port'] = 22
default['inspec_cron']['targets_protocol'] = 'ssh'
default['inspec_cron']['targets_sudo'] = false
default['inspec_cron']['targets_user'] = nil
