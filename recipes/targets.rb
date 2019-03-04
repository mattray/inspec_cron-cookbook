#
# Cookbook:: inspec-cron
# Recipe:: targets
#

include_recipe 'audit::inspec'

target_dir = node['inspec-cron']['conf_dir'] + "/targets"

directory target_dir do
  recursive true
end

node['inspec-cron']['targets'].each do |name, settings|
  prefix = target_dir + '/' + name

  # write out a node_uuid file for each target
  if settings['node_uuid']
    node_uuid = settings['node_uuid']
  elsif File.exist?("#{prefix}-node_uuid") # read existing file
    node_uuid = File.read("#{prefix}-node_uuid")
  else # generate a uuid
    node_uuid = SecureRandom.uuid
  end

  file "#{prefix}-node_uuid" do
    content node_uuid
  end

  # write out a config file for each target
  if settings['environment']
    environment = settings['environment']
  else
    environment = node['inspec-cron']['environment']
  end

  if settings['token']
    token = settings['token']
  else
    token = node['inspec-cron']['token']
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
