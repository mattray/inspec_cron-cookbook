#
# Cookbook:: inspec_cron
# Recipe:: profiles
#

chef_ingredient 'inspec' do
  version node['inspec_cron']['version']
  platform_version_compatibility_mode true
end

node['inspec_cron']['profiles'].each do |name, profile|
  # sort out the command
  command = node['inspec_cron']['path']
  command += " exec #{profile['url']}"
  command += " --json-config #{node['inspec_cron']['conf_dir']}/#{node['inspec_cron']['conf_file']}"

  # sort out the cron schedule
  # set to the defaults
  minute = node['inspec_cron']['cron']['minute']
  hour = node['inspec_cron']['cron']['hour']
  day = node['inspec_cron']['cron']['day']
  weekday = node['inspec_cron']['cron']['weekday']
  month = node['inspec_cron']['cron']['month']
  # if the profile hash sets anything, blank all the of the fields
  if profile['minute'] || profile['hour'] || profile['day'] || profile['weekday'] || profile['month']
    minute = '*'
    hour = '*'
    day = '*'
    weekday = '*'
    month = '*'
  end
  minute = profile['minute'] if profile['minute']
  hour = profile['hour'] if profile['hour']
  day = profile['day'] if profile['day']
  weekday = profile['weekday'] if profile['weekday']
  month = profile['month'] if profile['month']

  # create the cron job
  cron name do
    command command
    minute minute
    hour hour
    day day
    weekday weekday
    month month
  end
end
