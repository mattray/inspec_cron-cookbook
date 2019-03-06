#
# Cookbook:: inspec-cron
# Recipe:: profiles
#

chef_ingredient 'inspec' do
  version node['inspec-cron']['version']
  platform_version_compatibility_mode true
end

node['inspec-cron']['profiles'].each do |name, profile|
  # sort out the command
  command = node['inspec-cron']['path']
  command += " exec #{profile['url']}"
  command += " --json-config #{node['inspec-cron']['conf_dir']}/#{node['inspec-cron']['conf_file']}"

  # sort out the cron schedule
  # set to the defaults
  minute = node['inspec-cron']['cron']['minute']
  hour = node['inspec-cron']['cron']['hour']
  day = node['inspec-cron']['cron']['day']
  weekday = node['inspec-cron']['cron']['weekday']
  month = node['inspec-cron']['cron']['month']
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
