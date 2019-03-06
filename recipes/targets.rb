#
# Cookbook:: inspec-cron
# Recipe:: targets
#

chef_ingredient 'inspec' do
  version node['inspec-cron']['version']
  platform_version_compatibility_mode true
end

target_dir = node['inspec-cron']['conf_dir'] + '/targets'

directory target_dir do
  recursive true
end

node['inspec-cron']['targets'].each do |name, settings|
  prefix = target_dir + '/' + name

  # write out a node_uuid file for each target
  file_node_uuid = "#{prefix}-node_uuid"

  node_uuid = if settings['node_uuid']
                settings['node_uuid']
              elsif File.exist?(file_node_uuid) # read existing file
                File.read(file_node_uuid)
              else # generate a uuid
                SecureRandom.uuid
              end

  file file_node_uuid do
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

  inspec_json = "#{prefix}-#{node['inspec-cron']['conf_file']}"
  template inspec_json do
    source 'inspec.json.erb'
    variables(environment: environment,
              insecure: node['inspec-cron']['insecure'],
              node_name: name,
              node_uuid: node_uuid,
              token: token,
              url: server_url)
  end

  # loop over the profiles
  settings['profiles'].each do |pro_name, profile|
    # sort out the command
    command = node['inspec-cron']['path']
    command += " exec #{profile['url']}"
    protocol = if settings['protocol']
                 settings['protocol']
               else
                 node['inspec-cron']['targets_protocol']
               end
    user = if settings['user']
             settings['user']
           elsif node['inspec-cron']['targets_user']
             node['inspec-cron']['targets_user']
           end
    port = if settings['port']
             settings['port']
           else
             node['inspec-cron']['targets_port']
           end
    password = if settings['password']
                 settings['password']
               elsif
                 node['inspec-cron']['targets_password']
               end
    key = if settings['key']
            settings['key']
          elsif
            node['inspec-cron']['targets_key']
          end
    sudo = node['inspec-cron']['targets_sudo']
    sudo = settings['sudo'] unless settings['sudo'].nil?
    command += " -t #{protocol}://"
    command += "#{user}@" if user
    command += "#{name} --port=#{port}"
    command += " --password=#{password}" if password
    command += " -i=#{key}" if key
    command += ' --sudo' if sudo
    command += " --json-config #{inspec_json}"

    # sort out the cron schedule
    # set to the defaults
    minute = node['inspec-cron']['cron']['minute']
    hour = node['inspec-cron']['cron']['hour']
    day = node['inspec-cron']['cron']['day']
    weekday = node['inspec-cron']['cron']['weekday']
    month = node['inspec-cron']['cron']['month']
    # if the profile hash sets anything, blank all the of the fields
    if profile['minute'] || profile['hour'] || profile['day'] || profile['weekday'] || profile['month']
      minute = '*'
      hour = '*'
      day = '*'
      weekday = '*'
      month = '*'
    end
    minute = profile['minute'] if profile['minute']
    hour = profile['hour'] if profile['hour']
    day = profile['day'] if profile['day']
    weekday = profile['weekday'] if profile['weekday']
    month = profile['month'] if profile['month']

    # # create the cron job
    cron "#{name}::#{pro_name}" do
      command command
      minute minute
      hour hour
      day day
      weekday weekday
      month month
    end
  end
end
