#
# Cookbook Name:: zip_build
# Recipe:: vagrant
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

directory 'vagrant-user-maven-dotm2-directory' do
  path '/home/vagrant/.m2'
  action :create
  owner 'vagrant'
  group 'vagrant'
end

template 'vagrant-user-maven-settings-xml' do
  source 'settings.xml.erb'
  path '/home/vagrant/.m2/settings.xml'
  owner 'vagrant'
  group 'vagrant'
end

