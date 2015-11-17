#
# Cookbook Name:: zabbix::server
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Server Install
%w[
  zabbix-server-mysql
  zabbix-web-mysql
  zabbix-web-japanese
].each do |p|
  package p do
    version "#{node['zabbix']['server']['version']}-1.el6"
  end
end

# Install php-fpm to execute PHP code from nginx
package 'php5-fpm'


# Zabbix Server Setting
template '/etc/zabbix/zabbix_server.conf' do
  source 'zabbix_server.conf.erb'
  owner 'root'
  group 'root'
  mode '644'
  variables(
    :dbhost     => node['zabbix']['server']['mysql']['dbhost'],
    :dbname     => node['zabbix']['server']['mysql']['dbname'],
    :dbuser     => node['zabbix']['server']['mysql']['dbuser'],
    :dbpassword => node['zabbix']['server']['mysql']['dbpassword']
  )
  notifies :restart, 'service[zabbix_server]'
end

# zabbix-agentの自動起動設定と起動
service "zabbix-agent" do
  supports :status => true, :restart => true
  action :restart
end
