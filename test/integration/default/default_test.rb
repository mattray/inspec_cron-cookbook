# # encoding: utf-8

# Inspec test for recipe inspec_cron::default

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
