#
# Cookbook Name:: zabbix::skype
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Skype Install 準備
%w[
  Xvfb
  x11vnc
  vnc-java
  python-pip
  python-virtualenv
  software-properties-common
].each do |p|
  package p
end

# 実行完了用判定Directory
directory "/root/chef_install" do
	owner "root"
	group "root"
	mode 00744
	action :create
end

# Skype Install
bash "skype install" do
  not_if { File.exists?("/root/chef_install/skype_install")}
  user "root"
  code <<-EOS
    sudo dpkg --add-architecture i386
    sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    sudo apt-get update
    sudo apt-get install -y skype
    touch /root/chef_install/skype_install
  EOS
end

# Sevabot Install
bash "sevabot install" do
  not_if { File.exists?("/root/chef_install/sevabot_install")}
  user "root"
  code <<-EOS
    pip install sevabot
    touch /root/chef_install/sevabot_install
  EOS
end

