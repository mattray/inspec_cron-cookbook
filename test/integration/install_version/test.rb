# # encoding: utf-8

# Inspec test for recipe inspec_cron::install-inspec

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
