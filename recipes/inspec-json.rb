#
# Cookbook:: inspec_cron
# Recipe:: inspec-json
#

inspec_json node['inspec_cron']['conf_file'] do
  node_name node['inspec_cron']['name']
  node_uuid node['inspec_cron']['uuid']
  environment node['inspec_cron']['environment']
  token node['inspec_cron']['token']
  insecure node['inspec_cron']['insecure']
  server_url node['inspec_cron']['server_url']
end
