#
# Cookbook Name:: miner-deploy
# Recipe:: common
#

# Deployユーザ作成
USER = node["common"]["deploy_user"]
GROUP = node["common"]["deploy_group"]
HOME = '/home/' + USER

group GROUP do
	group_name GROUP
	action [:create]
end

user USER do
	shell '/bin/zsh'
	home '/home/' + USER
  group 'miner'
	password nil
	supports :manage_home => true, :non_unique => false
	action   [:create]
end

template ".zshrc" do
	path HOME + "/.zshrc"
	source "zshrc.erb"
	owner USER
	group GROUP
	mode 00744
end

directory HOME + "/plugin/" do
	owner USER
	group GROUP
	mode 00764
	action :create
end

git HOME + "/plugin/auto-fu.zsh" do
	user USER
	group GROUP
	repository "https://github.com/hchbaw/auto-fu.zsh.git"
	revision "master"
	action :checkout
end


# ssh key
directory HOME + "/.ssh" do
  owner USER
  group GROUP
  mode 0700
  action :create
  only_if "test -d #{HOME}"
end

template "authorized_keys" do
	path HOME + "/.ssh/authorized_keys"
  source "id_rsa.pub"
	owner USER
	group GROUP
	mode 00600
end

template ".ssh/config" do
  path HOME + "/.ssh/config"
  source "ssh_config"
  owner USER
  group GROUP
  mode 00600
end

package 'libmysqlclient-dev'
package 'npm'
package 'nodejs'

link "/usr/bin/node" do
  to "/usr/bin/nodejs"
end
