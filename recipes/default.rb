#
# Cookbook Name:: zip_build
# Recipe:: default
#
# Copyright (C) 2015 Justin Alan Ryan (ZipRealty / Realogy)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['platform'] == 'debian'
  include_recipe 'debian::backports'
end
#include_recipe 'zip_common::default'
include_recipe 'zip_build::java'
#include_recipe 'zip_build::ruby'
#include_recipe 'zip_build::nodejs'
#include_recipe 'chef-dk'
include_recipe 'poise-python'
include_recipe 'git'

# should be def with users cookbook
user node[:zip_build][:user]
group node[:zip_build][:user]

# need to place a valid id_rsa in ~vagrant/.ssh
# shouldn't have passphrase
# should be given to 'zip' with users cookbook
# and encrypted data bags

# also need stash host key in ~/.ssh/known_hosts
#git node[:zip_build][:deployment_scripts_path] do
#  repository 'ssh://git@stash.aur.ziprealty.com:7999/ops/zip.deploy.git'
#  action     :sync
#end

directory node[:zip_build][:deployment_scripts_path] do
  owner user
  group group
  action :create
end

python_virtualenv node[:zip_build][:deployment_scripts_path]

directory node[:zip_build][:bamboo_agent_home] do
  owner user
  group group
  action :create
end

directory "#{node[:zip_build][:bamboo_agent_home]}/.m2" do
  owner user
  group group
  action :create
end

directory "#{node[:zip_build][:bamboo_agent_home]}/agents" do
  owner user
  group group
  action :create
end

agent_count = node[:zip_build][:bamboo_agent_count]

(0..agent_count).each do |i|
  directory "#{node[:zip_build][:bamboo_agent_home]}/agents/#{i}" do
    owner user
    group group
    action :create
  end

  template "#{node[:zip_build][:bamboo_agent_home]}/agents/#{i}/run" do
    source 'bamboo-agent-run.erb'
    owner user
    group group
    action :create
    mode 0755
    variables({
     :home => node[:zip_build][:bamboo_agent_home],
     :version => node[:zip_build][:bamboo_agent_version],
     :server_url => node[:zip_build][:bamboo_agent_server_url],
     :count => i
    })
  end
end

template "#{node[:zip_build][:bamboo_agent_home]}/.m2/settings.xml" do
  source 'm2-settings-xml.erb'
end

remote_file "#{node[:zip_build][:bamboo_agent_home]}/atlassian-bamboo-agent-installer-#{node[:zip_build][:bamboo_agent_version]}.jar" do
  source "http://bamboo.aur.test.ziprealty.com/agentServer/agentInstaller/atlassian-bamboo-agent-installer-#{node[:zip_build][:bamboo_agent_version]}"
end
