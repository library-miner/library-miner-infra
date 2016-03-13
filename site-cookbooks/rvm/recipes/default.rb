#
# Cookbook Name:: rvm
# Recipe:: default
#

###########
#実行完了用判定Directory
###########
directory "/root/chef_install" do
	owner "root"
	group "root"
	mode 00744
	action :create
end

############
#RVM Install
############
#最初の一回しか実行できません。
#2回目以降は手動でコマンドを実行してください
bash "rvm install" do
	not_if { File.exists?("/root/chef_install/rvm")}
	user "root"
	code <<-EOS
	command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
	curl -L https://get.rvm.io | bash -s stable --ruby
	source /etc/profile.d/rvm.sh
	echo "source /etc/profile.d/rvm.sh" >> /root/.bashrc
  rvm install ruby-2.2.3
  rvm --default use ruby-2.2.3
	touch /root/chef_install/rvm
	EOS
end

