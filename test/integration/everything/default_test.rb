# # encoding: utf-8

# Inspec test for recipe inspec_cron::default

# inspec checks
describe file('/opt/inspec/bin/inspec') do
  it { should exist }
end

describe command('inspec') do
  it { should exist }
end

describe command('inspec --version') do
  its('stdout') { should match /^4.20.10$/ }
end

describe package('inspec') do
  it { should be_installed }
  its('version') { should eq '4.20.10-1.el7' }
end

describe directory('/etc/chef') do
  it { should exist }
end

describe file('/etc/chef/inspec.json') do
  it { should exist }
end

describe json('/etc/chef/inspec.json') do
  its(%w(reporter automate environment)) { should eq 'local' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate node_uuid)) { should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/ }
  its(%w(reporter automate token)) { should eq '35V9X1VO0VRSeUjukPmBsihvwXI=' }
  its(%w(reporter automate url)) { should eq 'https://automate.example.com/data-collector/v0/' }
end

describe directory('/etc/chef/targets') do
  it { should exist }
end

%w(10.0.0.2 10.0.0.3 10.0.0.4 10.0.0.12 10.0.0.13 10.0.0.14).each do |target|
  describe file("/etc/chef/targets/#{target}/node_uuid") do
    it { should exist }
  end

  describe json("/etc/chef/targets/#{target}/inspec.json") do
    its(%w(reporter automate insecure)) { should eq true }
    its(%w(reporter automate node_name)) { should eq target }
    its(%w(reporter automate node_uuid)) { should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/ }
    its(%w(reporter automate stdout)) { should eq false }
    its(%w(reporter automate token)) { should eq '35V9X1VO0VRSeUjukPmBsihvwXI=' }
    its(%w(reporter automate url)) { should eq 'https://automate.example.com/data-collector/v0/' }
  end
end

# Chef Name: inspec-cron: everything-centos-7: linux-patch-baseline
# 15 */6 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/archive/0.4.0.zip --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '15' }
  its('hours') { should cmp '*/6' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: everything-centos-7: ssh-baseline
# 45 * * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz --json-config /etc/chef/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '45' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: everything-centos-7: uptime
# 0 */12 * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile --json-config /etc/chef/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile --json-config /etc/chef/inspec.json') do
  its('minutes') { should cmp '0' }
  its('hours') { should cmp '*/12' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.2: uptime
# */10 * * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://scanner@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://scanner@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json') do
  its('minutes') { should cmp '*/10' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.3: linux-patch-baseline
# 0 */12 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://scanner@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://scanner@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3/inspec.json') do
  its('minutes') { should cmp '0' }
  its('hours') { should cmp '*/12' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.3: uptime
# */5 * * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://scanner@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://scanner@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3/inspec.json') do
  its('minutes') { should cmp '*/5' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.4: uptime
# */7 * * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://scanner@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://scanner@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.4: ssh-baseline
# */7 */2 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://scanner@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://scanner@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.12: linux-patch-baseline
# */7 */2 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.12 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.12/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.12 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.12/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.12: ssh-baseline
# * 4 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.12 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.12/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.12 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.12/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.12: uptime
# * 4 * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.12 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.12/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.12 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.12/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.13: linux-patch-baseline
# */7 */2 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.13 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.13/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.13 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.13/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.13: ssh-baseline
# * 4 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.13 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.13/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.13 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.13/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.13: uptime
# * 4 * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.13 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.13/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.13 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.13/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.14: linux-patch-baseline
# */7 */2 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.14 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.14/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.14 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.14/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.14: ssh-baseline
# * 4 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.14 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.14/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.14 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.14/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.14: uptime
# * 4 * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.14 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.14/inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.14 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.14/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end
