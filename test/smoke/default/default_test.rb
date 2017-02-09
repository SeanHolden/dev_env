# # encoding: utf-8

# Inspec test for recipe dev_env::default

describe directory('/home/vagrant/code') do
  it { should exist }
end

describe directory('/home/vagrant/code/test_app') do
  it { should exist }
end
