#
# Cookbook Name:: miner-deploy
# Recipe:: deploy-miner-crawler-only
#

USER = node["common"]["deploy_user"]
GROUP = node["common"]["deploy_group"]

directory "/var/www/" do
	owner USER
	group GROUP
	mode 00777
	action :create
end
