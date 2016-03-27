#
# Cookbook Name:: miner-web-frontyard
# Recipe:: deploy-web-frontyard
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
template "#{node['nginx']['dir']}/sites-available/web-frontyard" do
  source 'web_frontyard_site.erb'
  owner  'root'
	group  'root'
	mode   '0644'
	notifies :reload, 'service[nginx]'
end

#simbol link
link "#{node['nginx']['dir']}/sites-enabled/web-frontyard" do
	not_if "test -L /#{node['nginx']['dir']}/sites-enabled/web-frontyard"
	to "/#{node['nginx']['dir']}/sites-available/web-frontyard"
	link_type :symbolic
	notifies :reload, 'service[nginx]'
end


