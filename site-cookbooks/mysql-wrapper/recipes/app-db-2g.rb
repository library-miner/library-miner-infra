#
# Cookbook Name:: mysql-wrapper
# Recipe:: app-db-2g
#

node.set['mysql']['server_root_password'] = 'root'
node.set['mysql']['port'] = '3306'

include_recipe 'mysql::server'

template '/etc/mysql/conf.d/mysite.cnf' do
  owner 'root'
  owner 'root'
  source 'app-db-2g.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end
