resource_name :inspec_cron

property :profile_name, String, name_property: true, required: true
property :profile_url, String
property :node_name, String
property :inspec_uuid, String
property :inspec_json, String, required: true
property :inspec_path, String, default: '/opt/chef/embedded/bin/inspec'
property :minute, String
property :hour, String
property :day, String
property :month, String
property :weekday, String

action :create do
  json_config = new_resource.inspec_json

  # sort out the node_uuid file
  file_inspec_uuid = ::File.dirname(json_config) + '/inspec_uuid'

  inspec_uuid = if new_resource.inspec_uuid
                new_resource.inspec_uuid
              elsif File.exist?(file_inspec_uuid) # read existing file
                File.read(file_inspec_uuid)
              else # generate a uuid
                SecureRandom.uuid
              end

  file file_inspec_uuid do
    content inspec_uuid
    sensitive true
    not_if { ::File.exist?(::File.dirname(file_inspec_uuid) + '/chef_guid') }
  end

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
