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
package "zabbix-agent"

# Install configuration
#template '/etc/zabbix/zabbix_agentd.conf' do
#  source 'zabbix_agentd.conf.erb'
#  owner 'root'
#  group 'root'
#  mode '644'
#end

# zabbix-agentの自動起動設定と起動
service "zabbix-agent" do
  supports :status => true, :restart => true
  action :restart
end
