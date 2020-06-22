# # encoding: utf-8

# Inspec test for recipe inspec_cron::install-inspec

describe file('/opt/inspec/bin/inspec') do
  it { should_not exist }
end

describe command('inspec') do
  it { should_not exist }
end

describe command('/opt/chef/embedded/bin/inspec --version') do
  its('stdout') { should match /^4.18.114$/ }
end

describe package('inspec') do
  it { should_not be_installed }
end
