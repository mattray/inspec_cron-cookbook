# if you need an alternate version of inspec, make sure you update the
# node['inspec_cron']['path'] if necessary

if node['inspec_cron']['version'] || node['inspec_cron']['package_source']
  chef_ingredient 'inspec' do
    action :install
    version node['inspec_cron']['version']
    channel node['inspec_cron']['channel']
    package_source node['inspec_cron']['package_source']
    platform_version_compatibility_mode true
  end
end
