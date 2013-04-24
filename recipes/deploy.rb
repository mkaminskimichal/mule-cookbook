#
# Cookbook Name:: mule
# Recipe:: default
#
# Copyright 2011, Michał Kamiński
#
# LGPL 2.0 or, at your option, any later version
#

git_clone "clone repo" do
   repository "#{node['project']['repository']}"
   directory "#{node['workspace']['directory']}"
end

mvn_install "project install" do
   directory "#{node['workspace']['directory']}/#{node['project']['name']}"
end
