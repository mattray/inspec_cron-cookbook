# # encoding: utf-8

# Inspec test for recipe inspec-cron::default

describe directory('/etc/chef/targets') do
  it { should exist }
end

%w(10.0.0.3 10.0.0.4 ndnd).each do |target|
  describe file("/etc/chef/targets/#{target}-node_uuid") do
    it { should exist }
  end

  describe file("/etc/chef/targets/#{target}-inspec.json") do
    it { should exist }
  end

end

describe file('/etc/chef/targets/10.0.0.3-node_uuid') do
  its('content') { should match(/c0411e97-3976-410f-83a1-22ab3b40638c/) }
end

describe json('/etc/chef/targets/10.0.0.3-inspec.json') do
  its(['reporter', 'automate', 'environment']) { should eq 'foo' }
  its(['reporter', 'automate', 'insecure']) { should eq true }
  its(['reporter', 'automate', 'node_name']) { should eq '10.0.0.3' }
  its(['reporter', 'automate', 'stdout']) { should eq false }
  its(['reporter', 'automate', 'token']) { should eq 'vWswevpNZb7OXJ0jXF11TYxbHZE=' }
  its(['reporter', 'automate', 'url']) { should eq 'https://ndnd/data-collector/v0/' }
end

describe file('/etc/chef/targets/10.0.0.4-node_uuid') do
end

describe json('/etc/chef/targets/10.0.0.4-inspec.json') do
  its(['reporter', 'automate', 'environment']) { should eq '_default' }
  its(['reporter', 'automate', 'insecure']) { should eq true }
  its(['reporter', 'automate', 'node_name']) { should eq '10.0.0.4' }
  its(['reporter', 'automate', 'stdout']) { should eq false }
  its(['reporter', 'automate', 'token']) { should eq '8ZzgdoqAPRWsW4XOHRiFx7Kbobk=' }
  its(['reporter', 'automate', 'url']) { should eq 'https://ndnd/data-collector/v0/' }
end

describe file('/etc/chef/targets/ndnd-node_uuid') do
end

describe json('/etc/chef/targets/ndnd-inspec.json') do
  its(['reporter', 'automate', 'environment']) { should eq '_default' }
  its(['reporter', 'automate', 'insecure']) { should eq true }
  its(['reporter', 'automate', 'node_name']) { should eq 'ndnd' }
  its(['reporter', 'automate', 'stdout']) { should eq false }
  its(['reporter', 'automate', 'token']) { should eq '8ZzgdoqAPRWsW4XOHRiFx7Kbobk=' }
  its(['reporter', 'automate', 'url']) { should eq 'https://ndnd/data-collector/v0/' }
end

# describe crontab do
#   its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json' }
#   its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz --json-config /etc/chef/inspec.json' }
#   its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile --json-config /etc/chef/inspec.json' }
# end

# describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json') do
#   its('minutes') { should cmp '15' }
#   its('hours') { should cmp '*/6' }
#   its('days') { should cmp '*' }
#   its('weekdays') { should cmp '*' }
#   its('months') { should cmp '*' }
# end

# describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz --json-config /etc/chef/inspec.json') do
#   its('minutes') { should cmp '45' }
#   its('hours') { should cmp '*' }
#   its('days') { should cmp '*' }
#   its('weekdays') { should cmp '*' }
#   its('months') { should cmp '*' }
# end

# describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile --json-config /etc/chef/inspec.json') do
#   its('minutes') { should cmp '0' }
#   its('hours') { should cmp '*/4' }
#   its('days') { should cmp '*' }
#   its('weekdays') { should cmp '*' }
#   its('months') { should cmp '*' }
# end
