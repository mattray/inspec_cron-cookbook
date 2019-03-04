#
# Cookbook:: inspec-cron
# Recipe:: targets
#

include_recipe 'audit::inspec'

target_dir = node['inspec-cron']['conf_dir'] + '/targets'

directory target_dir do
  recursive true
end

node['inspec-cron']['targets'].each do |name, settings|
  prefix = target_dir + '/' + name

  # write out a node_uuid file for each target
  node_uuid = if settings['node_uuid']
                settings['node_uuid']
              elsif File.exist?("#{prefix}-node_uuid") # read existing file
                File.read("#{prefix}-node_uuid")
              else # generate a uuid
                SecureRandom.uuid
              end

  file "#{prefix}-node_uuid" do
    content node_uuid
  end

  # write out a config file for each target
  environment = if settings['environment']
                  settings['environment']
                else
                  node['inspec-cron']['environment']
                end
  token = if settings['token']
            settings['token']
          else
            node['inspec-cron']['token']
          end

  server_url = node['inspec-cron']['server_url']

  template "#{prefix}-#{node['inspec-cron']['conf_file']}" do
    source 'inspec.json.erb'
    variables(environment: environment,
              insecure: node['inspec-cron']['insecure'],
              node_name: name,
              node_uuid: node_uuid,
              token: token,
              url: server_url)
  end
end
