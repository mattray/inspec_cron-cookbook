#
# Cookbook:: inspec_cron
# Recipe:: profiles
#

chef_ingredient 'inspec' do
  version node['inspec_cron']['version']
  platform_version_compatibility_mode true
end

# iterate over the profiles
node['inspec_cron']['profiles'].each do |name, profile|
  inspec_cron name do
    node_name node['inspec_cron']['name']
    inspec_json node['inspec_cron']['conf_file']
    inspec_path node['inspec_cron']['path']
    profile_url profile['url']
    minute profile['minute']
    hour profile['hour']
    day profile['day']
    weekday profile['weekday']
    month profile['month']
  end
end
