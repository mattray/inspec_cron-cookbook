resource_name :inspec_json

property :file, String, name_property: true
property :node_name, String, required: true
property :node_uuid, String
property :uuid_file, String
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

  # if no UUID is passed, create one
  uuid = new_resource.node_uuid
  if uuid.nil?
    # write out a node_uuid file for each target
    # file_node_uuid = "#{prefix}-node_uuid"
    # node_uuid = if settings['node_uuid']
    #               settings['node_uuid']
    #             elsif File.exist?(file_node_uuid) # read existing file
    #               File.read(file_node_uuid)
    #             else # generate a uuid
    #               SecureRandom.uuid
    #             end
    #
    uuid = '1234'
  end

  # write the inspec.json
  template json_file do
    source 'inspec.json.erb'
    mode '0700'
    variables(
      node_name: new_resource.node_name,
      node_uuid: uuid,
      environment: new_resource.environment,
      insecure: new_resource.insecure,
      token: new_resource.token,
      url: new_resource.server_url
    )
  end
end
