# # encoding: utf-8

# Inspec test for recipe inspec-cron::default

describe directory('/etc/chef') do
  it { should exist }
end

describe file('/etc/chef/inspec.json') do
  it { should exist }
end

describe crontab do
  its('commands') { should include '/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json' }
end

describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '*/5' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
end
