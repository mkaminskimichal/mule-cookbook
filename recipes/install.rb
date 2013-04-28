#
# Cookbook Name:: mule
# Recipe:: default
#
# Copyright 2011, Michał Kamiński
#
# LGPL 2.0 or, at your option, any later version
#
include_recipe "java"


ZIP_FILE = "mule-standalone-3.3.1.zip"
MULE_URL = "http://dist.codehaus.org/mule/distributions/#{ZIP_FILE}"

#download mule zip file
remote_file "#{node['mule']['install_dir']}/#{ZIP_FILE}" do
  source MULE_URL
  action :nothing
end

#only if it has changed
http_request "HEAD #{MULE_URL}" do
  message ""
  url MULE_URL
  action :head
  if File.exists?("#{node['mule']['install_dir']}/#{ZIP_FILE}")
    headers "If-Modified-Since" => File.mtime("#{node['mule']['install_dir']}/#{ZIP_FILE}").httpdate
  end
  notifies :create, resources(:remote_file => "#{node['mule']['install_dir']}/#{ZIP_FILE}"), :immediately
end

package "unzip" do
  action :install
end

#unzip mule
execute "unzip" do
  command "unzip #{node['mule']['install_dir']}/#{ZIP_FILE} -d #{node['mule']['install_dir']}"
  creates "#{node['mule']['install_dir']}/#{ZIP_FILE.gsub('.zip', '')}"
  action :run
  notifies :run, "execute[run_mule]", :immediately
end

execute "run_mule"  do
  command "#{node['mule']['install_dir']}/#{ZIP_FILE.gsub('.zip', '')}/bin/mule > #{node['mule']['log_dir']}/mule.log &"
  creates "#{node['mule']['log_dir']}/mule.log"
  action :nothing
end

magic_shell_environment 'MULE_HOME' do
  value "#{node['mule']['install_dir']}/#{ZIP_FILE.gsub('.zip', '')}"
end

execute "MULE_HOME"  do
  command "/etc/profile.d/MULE_HOME.sh"
  action :run
end


