# # encoding: utf-8

# Inspec test for recipe inspec-cron::inspec-json

describe directory('/tmp/inspec') do
  it { should exist }
end

describe file('/tmp/inspec/inspec.json') do
  it { should exist }
end

describe json('/tmp/inspec/inspec.json') do
  its(['reporter', 'automate', 'environment']) { should eq 'local' }
  its(['reporter', 'automate', 'insecure']) { should eq true }
  its(['reporter', 'automate', 'node_name']) { should eq 'conf-centos-7' }
  its(['reporter', 'automate', 'stdout']) { should eq false }
  its(['reporter', 'automate', 'token']) { should eq '8ZzgdoqAPRWsW4XOHRiFx7Kbobk=' }
  its(['reporter', 'automate', 'url']) { should eq 'https://ndnd/data-collector/v0/' }
end
