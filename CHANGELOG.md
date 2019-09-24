# inspec_cron Cookbook CHANGELOG

This file is used to list changes made in each version of the inspec_cron cookbook.

## 0.3.0

- initial release

## 0.4.0

- renamed to inspec_cron
- updated minimum Chef version to 14
- inspec_json Custom Resource
- inspec_cron Custom Resource
- inspec_target Custom Resource
- add support for InSpec package_source and version

## 0.5.0

- support a list of target nodes that all behave the same
- no longer expect '/opt/inspec/bin/inspec' as the default path, set to '/opt/chef/embedded/bin/inspec'
- added 'everything' test to verify default and targets recipes together
