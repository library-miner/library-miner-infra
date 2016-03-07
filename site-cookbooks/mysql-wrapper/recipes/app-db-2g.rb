#
# Cookbook Name:: mysql-wrapper
# Recipe:: app-db-2g
#

include_recipe 'mysql-wrapper::default'

mysql_config 'default' do
  source 'app-db-2g.cnf.erb'
  notifies :restart, 'mysql_service[default]'
  action :create
end
