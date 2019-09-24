resource_name :inspec_cron

property :profile_name, String, name_property: true
property :profile_url, String
property :node_name, String
property :inspec_json, String, required: true
property :inspec_path, String, default: '/opt/chef/embedded/bin/inspec'
property :minute, String
property :hour, String
property :day, String
property :month, String
property :weekday, String

action :create do
  json_config = new_resource.inspec_json

  command = new_resource.inspec_path
  command += " exec #{new_resource.profile_url}"
  command += " --json-config #{json_config}"

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
  cron "inspec-cron: #{new_resource.node_name}: #{new_resource.profile_name}" do
    command command
    minute minute
    hour hour
    day day
    weekday weekday
    month month
  end
end
