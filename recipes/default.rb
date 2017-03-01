#
# Cookbook:: dev_env
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#

include_recipe 'ssh'
include_recipe 'git'
include_recipe 'ohmyzsh'

user = node['dev_env']['user']
repos = node['dev_env']['repos']

directory "/home/#{user}/code" do
  owner user
  group user
  mode '755'
end

repos.each do |repo|
  git "/home/#{user}/code/ReactReduxStarter" do
    repository repo
    checkout_branch 'master'
    enable_checkout false
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
