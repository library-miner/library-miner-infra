# server
# default['zabbix']['server']['version'] = '2.2.3'

default['zabbix']['server']['mysql']['dbhost'] = 'localhost'
default['zabbix']['server']['mysql']['dbname'] = 'zabbix'
default['zabbix']['server']['mysql']['dbuser'] = 'zabbix'
default['zabbix']['server']['mysql']['dbpassword'] = nil

default['zabbix']['web']['login'] = 'admin'
default['zabbix']['web']['password'] = 'zabbix'
default['zabbix']['web']['install_method']  = 'apache'
default['zabbix']['web']['fqdn']            = node['fqdn']
default['zabbix']['web']['aliases']         = ['zabbix']
default['zabbix']['web']['port']            = 80

default['zabbix']['web']['php']['fastcgi_listen'] = '127.0.0.1:9000' # only applicable when using php-fpm (nginx)
default['zabbix']['web']['php']['settings']    = {
  'memory_limit'        => '128M',
  'post_max_size'       => '32M',
  'upload_max_filesize' => '16M',
  'max_execution_time'  => '600',
  'max_input_time'      => '600',
  'date.timezone'       => "'UTC'",
}
