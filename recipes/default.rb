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
include_recipe 'zip_common::default'
include_recipe 'zip_build::java'
#include_recipe 'zip_build::ruby'
include_recipe 'zip_build::nodejs'
#include_recipe 'chef-dk'
include_recipe 'poise-python'
include_recipe 'git'

# should be def with users cookbook
user 'zip'

# need to place a valid id_rsa in ~vagrant/.ssh
# shouldn't have passphrase
# should be given to 'zip' with users cookbook
# and encrypted data bags

# also need stash host key in ~/.ssh/known_hosts
#git node[:zip_build][:deployment_scripts_path] do
#  repository 'ssh://git@stash.aur.ziprealty.com:7999/ops/zip.deploy.git'
#  action     :sync
#end

python_virtualenv node[:zip_build][:deployment_scripts_path] do
  owner 'zip'
  group 'zip'
  action :create
end

python_pip 'fabric' do
  virtualenv node[:zip_build][:deployment_scripts_path]
end
