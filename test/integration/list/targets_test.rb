# # encoding: utf-8

# Inspec test for recipe inspec_cron::list

describe directory('/etc/chef/targets') do
  it { should exist }
end

%w(10.0.0.2 10.0.0.3 10.0.0.4).each do |target|
  describe file("/etc/chef/targets/#{target}/node_uuid") do
    it { should exist }
  end

  describe file("/etc/chef/targets/#{target}/inspec.json") do
    it { should exist }
  end
end

describe json('/etc/chef/targets/10.0.0.2/inspec.json') do
  its(%w(reporter automate environment)) { should eq 'legacy' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq '10.0.0.2' }
  its(%w(reporter automate node_uuid)) { should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/ }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq '35V9X1VO0VRSeUjukPmBsihvwXI=' }
  its(%w(reporter automate url)) { should eq 'https://automate.example.com/data-collector/v0/' }
end

describe json('/etc/chef/targets/10.0.0.3/inspec.json') do
  its(%w(reporter automate environment)) { should eq 'legacy' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq '10.0.0.3' }
  its(%w(reporter automate node_uuid)) { should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/ }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq '35V9X1VO0VRSeUjukPmBsihvwXI=' }
  its(%w(reporter automate url)) { should eq 'https://automate.example.com/data-collector/v0/' }
end

describe json('/etc/chef/targets/10.0.0.4/inspec.json') do
  its(%w(reporter automate environment)) { should eq 'legacy' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq '10.0.0.4' }
  its(%w(reporter automate node_uuid)) { should match /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/ }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq '35V9X1VO0VRSeUjukPmBsihvwXI=' }
  its(%w(reporter automate url)) { should eq 'https://automate.example.com/data-collector/v0/' }
end

# Chef Name: inspec-cron: 10.0.0.2: linux-patch-baseline
# */7 */2 * * * /opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.2: ssh-baseline
# * 4 * * * /opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.2: uptime
# * 4 * * * /opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.3: linux-patch-baseline
# */7 */2 * * * /opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.3 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.3/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.3 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.3/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.3: ssh-baseline
# * 4 * * * /opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.3 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.3/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.3 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.3/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.3: uptime
# * 4 * * * /opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.3 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.3/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.3 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.3/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.4: linux-patch-baseline
# */7 */2 * * * /opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.4 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.4/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://auditor@10.0.0.4 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.4/inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.4: ssh-baseline
# * 4 * * * /opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.4 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.4/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://auditor@10.0.0.4 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.4/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: inspec-cron: 10.0.0.4: uptime
# * 4 * * * /opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.4 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.4/inspec.json
describe crontab.commands('/opt/chef/embedded/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://auditor@10.0.0.4 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.4/inspec.json') do
  its('minutes') { should cmp '*' }
  its('hours') { should cmp '4' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end
