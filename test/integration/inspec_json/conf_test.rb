# # encoding: utf-8

# Inspec test for recipe inspec_cron::inspec-json

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
