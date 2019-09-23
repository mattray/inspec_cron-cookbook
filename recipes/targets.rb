#
# Cookbook:: inspec_cron
# Recipe:: targets
#

chef_ingredient 'inspec' do
  version node['inspec_cron']['version']
  platform_version_compatibility_mode true
end

# each target has settings
node['inspec_cron']['targets'].each do |target_name, settings|
  # and the profiles within the settings may have additional settings
  settings['profiles'].each do |profile_name, profile|
    inspec_target target_name do
      target_uuid settings['node_uuid']
      target_environment settings['environment']
      target_token settings['token']
      target_inspec_json settings['inspec_json']
      target_key settings['key']
      target_password settings['password']
      target_port settings['port']
      target_protocol settings['protocol']
      target_sudo settings['sudo']
      target_user settings['user']
      profile_name profile_name
      profile_url profile['url']
      minute profile['minute'] || settings['minute']
      hour profile['hour'] || settings['hour']
      day profile['day'] || settings['day']
      weekday profile['weekday'] || settings['weekday']
      month profile['month'] || settings['month']
      inspec_path node['inspec_cron']['path']
    end
  end
end
