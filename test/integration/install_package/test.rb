# # encoding: utf-8

# Inspec test for recipe inspec_cron::install-inspec

describe command('inspec') do
  it { should exist }
end

describe command('inspec --version') do
  its('stdout') { should match /^4.17.4$/ }
end

describe package('inspec') do
  it { should be_installed }
  its('version') { should eq '4.17.4-1.el7' }
end
