#
# Cookbook:: inspec_cron
# Recipe:: inspec-json
#

dir = node['inspec_cron']['conf_dir']

directory dir do
  recursive true
end

# write the inspec.json
template "#{dir}/#{node['inspec_cron']['conf_file']}" do
  source 'inspec.json.erb'
  mode '0700'
  variables(environment: node['chef_environment'],
            insecure: node['inspec_cron']['insecure'],
            node_name: node['name'],
            node_uuid: node['chef_guid'],
            token: node['inspec_cron']['token'],
            url: node['inspec_cron']['server_url'])
end
