#
# Cookbook Name:: zabbix::mysql-client-monitor
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/etc/zabbix/mysql" do
	owner "zabbix"
	group "zabbix"
	mode 00744
	action :create
end


# DB情報記載ファイル
template "/etc/zabbix/mysql/my.conf" do
  source 'my.conf.erb'
	owner  'zabbix'
	group  'zabbix'
	mode   '0700'
  not_if { File.exists?("/etc/zabbix/mysql/my.conf")}
end

# Zabbix Agent で使用するキー情報
template "/etc/zabbix/zabbix_agentd.conf.d/userparameter_mysql.conf" do
  source 'zabbix_userparameter_mysql.conf.erb'
  owner 'zabbix'
  group 'zabbix'
  mode '0754'

  notifies :restart, resources(:service => "zabbix-agent")
end


# -- mysql データベース作成 初期データ投入 --

# 実行完了用判定Directory
directory "/root/chef_install" do
	owner "root"
	group "root"
	mode 00744
	action :create
end

# 後から入れる場合は注意
#root_password = node['mysql']['initial_root_password']
root_password = 'root'

# create user
bash "create zabbix db user" do
  not_if { File.exists?("/root/chef_install/zabbix_mysql_monitor_user_create")}
  user "root"
  code <<-EOS
    mysql -u root -p#{root_password} -e \
    "create user zabbix; \
    grant all on zabbix.* to zabbix@localhost; \
    flush privilegdes;"
    touch /root/chef_install/zabbix_mysql_monitor_user_create
  EOS
end


