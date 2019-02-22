#
# Cookbook:: inspec-cron
# Recipe:: profiles
#

include_recipe 'audit::inspec'

# switch to ['inspec-cron']['profiles'] some day with the cron schedule
profiles = node['audit']['profiles']

profiles.keys.each do |profile|
  command = node['inspec-cron']['inspec']['path']
  # throw some logic in here about how we're getting profiles
  command += " exec #{profiles[profile]['url']}"
  # command += " exec #{profile['compliance']}"
  # command += " exec #{profile['path']}"# ???
  # command += " exec #{profile['git']}"# ???
  command += ' --json-config /etc/chef/inspec.json'

  # at some point we could put the cron schedule into the hash
  minute = node['inspec-cron']['cron']['minute']
  hour = node['inspec-cron']['cron']['hour']
  day = node['inspec-cron']['cron']['day']

  # create the cron job
  cron 'inspec' do
    command command
    minute minute
    hour hour
    day day
  end
end
