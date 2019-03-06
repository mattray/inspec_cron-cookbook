# # encoding: utf-8

# Inspec test for recipe inspec-cron::default

describe directory('/etc/chef/targets') do
  it { should exist }
end

%w(10.0.0.2 10.0.0.3 10.0.0.4).each do |target|
  describe file("/etc/chef/targets/#{target}-node_uuid") do
    it { should exist }
  end

  describe file("/etc/chef/targets/#{target}-inspec.json") do
    it { should exist }
  end
end

describe json('/etc/chef/targets/10.0.0.2-inspec.json') do
  its(%w(reporter automate environment)) { should eq '_default' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq '10.0.0.2' }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq '8ZzgdoqAPRWsW4XOHRiFx7Kbobk=' }
  its(%w(reporter automate url)) { should eq 'https://ndnd/data-collector/v0/' }
end

describe file('/etc/chef/targets/10.0.0.3-node_uuid') do
  its('content') { should match(/aaaaaaaa-3976-410f-83a1-22ab3b40638c/) }
end

describe json('/etc/chef/targets/10.0.0.3-inspec.json') do
  its(%w(reporter automate environment)) { should eq 'foo' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq '10.0.0.3' }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq 'vWswevpNZb7OXJ0jXF11TYxbHZE=' }
  its(%w(reporter automate url)) { should eq 'https://ndnd/data-collector/v0/' }
end

describe file('/etc/chef/targets/10.0.0.4-node_uuid') do
  its('content') { should match(/11111111-2222-3333-4444-555555555555/) }
end

describe json('/etc/chef/targets/10.0.0.4-inspec.json') do
  its(%w(reporter automate environment)) { should eq '_default' }
  its(%w(reporter automate insecure)) { should eq true }
  its(%w(reporter automate node_name)) { should eq '10.0.0.4' }
  its(%w(reporter automate stdout)) { should eq false }
  its(%w(reporter automate token)) { should eq '8ZzgdoqAPRWsW4XOHRiFx7Kbobk=' }
  its(%w(reporter automate url)) { should eq 'https://ndnd/data-collector/v0/' }
end

# Chef Name: 10.0.0.2::uptime
# */10 * * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://test@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2-inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://test@10.0.0.2 --port=22 -i=/tmp/test.id_rsa --json-config /etc/chef/targets/10.0.0.2-inspec.json') do
  its('minutes') { should cmp '*/10' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: 10.0.0.3::linux-patch-baseline
# 0 */12 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://test@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3-inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/linux-patch-baseline/ -t ssh://test@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3-inspec.json') do
  its('minutes') { should cmp '0' }
  its('hours') { should cmp '*/12' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: 10.0.0.3::uptime
# */5 * * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://test@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3-inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://test@10.0.0.3 --port=22 --password=testing --sudo --json-config /etc/chef/targets/10.0.0.3-inspec.json') do
  its('minutes') { should cmp '*/5' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: 10.0.0.4::uptime
# */7 * * * * /opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://test@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4-inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/mattray/uptime-profile -t ssh://test@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4-inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end

# Chef Name: 10.0.0.4::ssh-baseline
# */7 */2 * * * /opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://test@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4-inspec.json
describe crontab.commands('/opt/inspec/bin/inspec exec https://github.com/dev-sec/ssh-baseline/archive/2.3.0.tar.gz -t ssh://test@10.0.0.4 --port=22 --password=testing --json-config /etc/chef/targets/10.0.0.4-inspec.json') do
  its('minutes') { should cmp '*/7' }
  its('hours') { should cmp '*/2' }
  its('days') { should cmp '*' }
  its('weekdays') { should cmp '*' }
  its('months') { should cmp '*' }
end
