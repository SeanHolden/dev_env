#
# Cookbook:: dev_env
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#

include_recipe 'git'
include_recipe 'ohmyzsh'

user = node['dev_env']['user']

directory "/home/#{user}/code" do
  owner user
  group user
  mode '755'
end

node['dev_env']['repos'].each do |repo|
  git "/home/#{user}/code/ReactReduxStarter" do
    repository repo
    user user
    group user
    environment ({ 'HOME' => "/home/#{user}", 'USER' => user })
    timeout 10
  end
end

template "/home/#{user}/.zshrc" do
  source 'zshrc.erb'
  owner user
  group user
  mode '644'
end
