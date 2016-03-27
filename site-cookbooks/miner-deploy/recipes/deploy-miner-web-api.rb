#
# Cookbook Name:: miner-deploy
# Recipe:: deploy-miner
#

USER = node["common"]["deploy_user"]
GROUP = node["common"]["deploy_group"]

directory "/var/www/" do
	owner USER
	group GROUP
	mode 00777
	action :create
end

# nginx
template "#{node['nginx']['dir']}/sites-available/default" do
	source 'rails_site_web_api.erb'
	owner  'root'
	group  'root'
	mode   '0644'
	notifies :reload, 'service[nginx]'
end

#simbol link
link "#{node['nginx']['dir']}/sites-enabled/default" do
	not_if "test -L /#{node['nginx']['dir']}/sites-enabled/default"
	to "/#{node['nginx']['dir']}/sites-available/default"
	link_type :symbolic
	notifies :reload, 'service[nginx]'
end


