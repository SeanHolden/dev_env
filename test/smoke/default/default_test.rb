# # encoding: utf-8

# Inspec test for recipe dev_env::default

describe directory('/home/vagrant/code') do
  it { should exist }
end
