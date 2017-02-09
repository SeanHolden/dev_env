#
# Cookbook:: dev_env
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#
user = node['dev_env']['user']
app_name = node['dev_env']['app_name']

directory "/home/#{user}/code" do
  owner 'vagrant'
  group 'vagrant'
  mode '755'
end

directory "/home/#{user}/code/#{app_name}" do
  owner 'vagrant'
  group 'vagrant'
  mode '755'
end
