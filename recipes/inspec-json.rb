#
# Cookbook:: inspec-cron
# Recipe:: inspec-json
#

# reuse the attribute from the chef_client cookbook
dir = if node['inspec-cron']['conf_dir'].nil?
        node['chef_client']['conf_dir']
      else
        node['inspec-cron']['conf_dir']
      end

# reuse the attribute from the audit cookbook
url = if node['inspec-cron']['server_url'].nil?
        node['chef_client']['config']['data_collector.server_url']
      else
        node['inspec-cron']['server_url']
      end

# reuse the attribute from the audit cookbook
token = if node['inspec-cron']['token'].nil?
          node['chef_client']['config']['data_collector.token']
        else
          node['inspec-cron']['token']
        end

# reuse the attribute from the audit cookbook
insecure = if node['inspec-cron']['insecure'].nil?
          node['audit']['insecure']
        else
          node['inspec-cron']['insecure']
        end

directory dir

# write the inspec.json
template "#{dir}/#{node['inspec-cron']['conf_file']}" do
  source 'inspec.json.erb'
  mode '0700'
  variables(environment: node['chef_environment'],
            insecure: insecure,
            node_name: node['name'],
            node_uuid: node['chef_guid'],
            token: token,
            url: url)
end
