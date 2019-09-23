resource_name :inspec_target

property :target_name, String, name_property: true, required: true
property :target_uuid, String
property :target_environment, String
property :target_token, String
property :target_inspec_json, String
property :target_key, String
property :target_password, String
property :target_port, String
property :target_protocol, String
property :target_sudo, [true, false], default: false
property :target_user, String
property :profile_name, String, required: true
property :profile_url, String
property :minute, String
property :hour, String
property :day, String
property :month, String
property :weekday, String
property :inspec_path, String, default: '/opt/chef/embedded/bin/inspec'

action :create do
  target_name = new_resource.target_name
  json_config = new_resource.target_inspec_json ? new_resource.target_inspec_json : "/etc/chef/targets/#{target_name}/inspec.json"

  # hold inspec.json and inspec_uuid in their own directory
  directory ::File.dirname(json_config) do
    recursive true
  end

  target_environment = new_resource.target_environment ? new_resource.target_environment : node['inspec_cron']['environment']
  target_token = new_resource.target_token ? new_resource.target_token : node['inspec_cron']['token']

  # write out a config file for each target
  inspec_json json_config do
    node_name target_name
    node_uuid new_resource.target_uuid
    environment target_environment
    token target_token
    insecure node['inspec_cron']['insecure']
    server_url node['inspec_cron']['server_url']
  end

  # sort out the command
  command = new_resource.inspec_path
  command += " exec #{new_resource.profile_url}"

  protocol = new_resource.target_protocol ? new_resource.target_protocol : node['inspec_cron']['targets_protocol']
  user = new_resource.target_user ? new_resource.target_user : node['inspec_cron']['targets_user']
  port = new_resource.target_port ? new_resource.target_port : node['inspec_cron']['targets_port']
  password = new_resource.target_password ? new_resource.target_password : node['inspec_cron']['targets_password']
  key = new_resource.target_key ? new_resource.target_key : node['inspec_cron']['targets_key']
  sudo = new_resource.target_sudo ? new_resource.target_sudo : node['inspec_cron']['targets_sudo']

  command += " -t #{protocol}://"
  command += "#{user}@" if user
  command += "#{target_name} --port=#{port}"
  command += " --password=#{password}" if password
  command += " -i=#{key}" if key
  command += ' --sudo' if sudo
  command += " --json-config #{json_config}"

  # sort out the cron schedule
  # if any times are set, blank the rest
  minute = new_resource.minute
  hour = new_resource.hour
  day = new_resource.day
  month = new_resource.month
  weekday = new_resource.weekday

  # if any of the resources are set, blank the unset ones
  if minute || hour || day || month || weekday
    minute = '*' if minute.nil?
    hour = '*' if hour.nil?
    day = '*' if day.nil?
    month = '*' if month.nil?
    weekday = '*' if weekday.nil?
  else # set to the node settings, potentially provided by the attributes
    minute = node['inspec_cron']['cron']['minute']
    hour = node['inspec_cron']['cron']['hour']
    day = node['inspec_cron']['cron']['day']
    weekday = node['inspec_cron']['cron']['weekday']
    month = node['inspec_cron']['cron']['month']
  end

  # create the cron job
  cron "inspec-cron: #{target_name}: #{new_resource.profile_name}" do
    command command
    minute minute
    hour hour
    day day
    weekday weekday
    month month
  end
end
