#
# Cookbook:: inspec-cron
# Recipe:: inspec-json
#

dir = node['inspec-cron']['conf_dir']

directory dir do
  recursive true
end

# write the inspec.json
template "#{dir}/#{node['inspec-cron']['conf_file']}" do
  source 'inspec.json.erb'
  mode '0700'
  variables(environment: node['chef_environment'],
            insecure: node['inspec-cron']['insecure'],
            node_name: node['name'],
            node_uuid: node['chef_guid'],
            token: node['inspec-cron']['token'],
            url: node['inspec-cron']['server_url'])
end
