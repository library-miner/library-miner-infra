#
# Cookbook Name:: zabbix
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# グループ作成
group "zabbix" do
  system true
end

# ユーザ作成
user "zabbix" do
  home '/opt/zabbix'
  shell '/bin/bash'
  group 'zabbix'
  system true
end

# Agent Install
kernel = node['kernel']['machine'] == 'x86_64' ? 'amd64' : 'i386'

ark 'zabbix_agent' do
  name 'zabbix'
  url "http://www.zabbix.com/downloads/#{node['zabbix']['agent']['version']}/zabbix_agents_#{node['zabbix']['agent']['version']}.linux2_6.#{kernel}.tar.gz"
  owner 'zabbix'
  group 'zabbix'
  action :put
  path '/opt'
  strip_components 0
  has_binaries ['bin/zabbix_sender', 'bin/zabbix_get', 'sbin/zabbix_agent', 'sbin/zabbix_agentd']
  notifies :restart, 'service[zabbix_agentd]'
end

# common directory 作成

