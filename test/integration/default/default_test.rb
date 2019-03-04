# # encoding: utf-8

# Inspec test for recipe inspec-cron::default

describe directory('/etc/chef') do
  it { should exist }
end

describe file('/etc/chef/inspec.json') do
  it { should exist }
end

describe json('/etc/chef/inspec.json') do
  its(%w(reporter automate environment)) { should eq 'local' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq 'default-centos-7' }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq '8ZzgdoqAPRWsW4XOHRiFx7Kbobk=' }
  its(%w(reporter automate url)) { should eq 'https://ndnd/data-collector/v0/' }
end

describe crontab do
  its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json' }
  its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz --json-config /etc/chef/inspec.json' }
  its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile --json-config /etc/chef/inspec.json' }
end

describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '15' }
  its('hours') { should cmp '*/6' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '45' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '0' }
  its('hours') { should cmp '*/4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end
