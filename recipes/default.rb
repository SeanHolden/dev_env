#
# Cookbook:: dev_env
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.
#

include_recipe 'ohmyzsh'
include_recipe 'ssh'
include_recipe 'git'

_user = node['dev_env']['user']
repos = node['dev_env']['repos']

directory "/home/#{_user}/code" do
  owner _user
  group _user
  mode '755'
end

repos.each do |repo|
  dir_name = /\w*.git$/.match(repo).to_s.sub('.git','')

  git "/home/#{_user}/code/#{dir_name}" do
    repository repo
    checkout_branch 'master'
    enable_checkout false
    user _user
    group _user
    environment ({ 'HOME' => "/home/#{_user}", 'USER' => _user })
    timeout 10
  end
end

template "/home/#{_user}/.zshrc" do
  source 'zshrc.erb'
  owner _user
  group _user
  mode '644'
end
