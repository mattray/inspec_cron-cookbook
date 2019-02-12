#
# Cookbook:: inspec-cron
# Recipe:: default
#

include_recipe 'audit::inspec'

dir = node['inspec-cron']['config']['directory']

directory dir

url = if node['inspec-cron']['server_url'].nil?
        node['chef_client']['config']['data_collector.server_url']
      else
        node['inspec-cron']['server_url']
      end

token = if node['inspec-cron']['token'].nil?
          node['chef_client']['config']['data_collector.token']
        else
          node['inspec-cron']['token']
        end

# write the inspec.json
template "#{dir}/inspec.json" do
  source 'inspec.json.erb'
  mode '0700'
  variables(environment: node['chef_environment'],
            node_name: node['name'],
            node_uuid: node['chef_guid'],
            token: token,
            url: url)
end

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
