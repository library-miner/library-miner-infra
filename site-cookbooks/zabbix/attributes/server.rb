# server
# default['zabbix']['server']['version'] = '2.2.3'


default['zabbix']['server']['log_file'] ='/var/log/zabbix-server/zabbix_server.log'
default['zabbix']['server']['log_level']              = 3
default['zabbix']['server']['housekeeping_frequency'] = '1'
default['zabbix']['server']['max_housekeeper_delete'] = '100000'

default['zabbix']['server']['timeout'] = '3'
default['zabbix']['server']['value_cache_size'] = '8M' # default 8MB
default['zabbix']['server']['cache_size'] = '8M' # default 8MB



default['zabbix']['server']['mysql']['dbhost'] = 'localhost'
default['zabbix']['server']['mysql']['dbname'] = 'zabbix'
default['zabbix']['server']['mysql']['dbuser'] = 'zabbix'
default['zabbix']['server']['mysql']['dbpassword'] = nil

default['zabbix']['web_dir'] = '/usr/share/zabbix'
default['zabbix']['web']['login'] = 'admin'
default['zabbix']['web']['password'] = 'zabbix'
default['zabbix']['web']['fqdn']            = node['fqdn']
default['zabbix']['web']['aliases']         = ['zabbix']
default['zabbix']['web']['port']            = 10080

default['zabbix']['web']['php']['fastcgi_listen'] = 'unix:/var/run/php5-fpm.sock' # only applicable when using php-fpm (nginx)
default['zabbix']['web']['php']['settings']    = {
  'memory_limit'        => '128M',
  'post_max_size'       => '32M',
  'upload_max_filesize' => '16M',
  'max_execution_time'  => '600',
  'max_input_time'      => '600',
  'date.timezone'       => "'UTC'",
}
