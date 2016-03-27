#
# Cookbook Name:: miner-deploy
# Recipe:: default
#

include_recipe 'miner-deploy::common'
include_recipe 'miner-deploy::deploy-miner-web-api'
include_recipe 'miner-deploy::common-library'
include_recipe 'miner-deploy::deploy-web-frontyard'
