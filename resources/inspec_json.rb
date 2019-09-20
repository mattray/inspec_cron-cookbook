resource_name :inspec_json

property :file, String, name_property: true
property :node_name, String, required: true
property :node_uuid, String
property :environment, String, required: true
property :insecure, [true, false], default: false
property :server_url, String, required: true
property :token, String, required: true


action :create do
  json_file = new_resource.file

  dir = ::File.dirname(json_file)

  directory dir do
    recursive true
  end

  # sort out the node_uuid file
  file_inspec_uuid = dir + '/inspec_uuid'

  inspec_uuid = if new_resource.node_uuid
                  new_resource.node_uuid
                elsif File.exist?(file_inspec_uuid) # read existing file
                  File.read(file_inspec_uuid)
                else # generate a uuid
                  SecureRandom.uuid
                end

  file file_inspec_uuid do
    content inspec_uuid
    sensitive true
    not_if { ::File.exist?("#{dir}/chef_guid") }
  end

  # write the inspec.json
  template json_file do
    source 'inspec.json.erb'
    mode '0700'
    variables(
      node_name: new_resource.node_name,
      node_uuid: inspec_uuid,
      environment: new_resource.environment,
      insecure: new_resource.insecure,
      token: new_resource.token,
      url: new_resource.server_url
    )
  end
end
