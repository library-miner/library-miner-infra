#
# Cookbook Name:: miner-deploy
# Recipe:: deploy-miner
#

USER = node["common"]["deploy_user"]
GROUP = node["common"]["deploy_group"]

directory "/var/www/" do
	owner USER
	group GROUP
	mode 00764
	action :create
end
