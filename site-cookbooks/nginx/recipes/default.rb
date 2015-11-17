#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, r_nishio
#

###########
#GROUP AND USER CREATE
###########
user 'nginx' do
	shell '/bin/bash'
	password nil
	action   [:create]
end

group 'nginx' do
	action [:modify]
	members ['nginx']
end

################
#Install nginx
################
package "nginx" do
	action :install
end

service 'nginx' do
	supports :status => true, :restart => true, :reload => true
	action   [:enable, :start]
end

################
#Create Directory
################
#Base Directory
directory node['nginx']['dir'] do
	owner     'root'
	group     'root'
	mode      '0755'
	recursive true
end

#site directory
%w(sites-available sites-enabled conf.d).each do |leaf|
  directory File.join(node['nginx']['dir'], leaf) do
    owner 'root'
    group 'root'
    mode  '0755'
  end
end

#Log Directory
directory node['nginx']['log_dir'] do
	mode      '0755'
	owner     node['nginx']['user']
	action    :create
	recursive true
end

##################
#Config File
##################

template 'nginx.conf' do
	path   "#{node['nginx']['dir']}/nginx.conf"
	source 'nginx.conf.erb'
	owner  'root'
	group  'root'
	mode   '0644'
  variables(
    :user => node['nginx']['user'],
    :install_dir => node['nginx']['dir'],
    :log_dir => node['nginx']['log_dir']
  )
	notifies :reload, 'service[nginx]'
end


