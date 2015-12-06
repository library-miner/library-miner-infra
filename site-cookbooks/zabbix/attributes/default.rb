# agent
default['zabbix']['agent']['hostname'] = node['fqdn']
default['zabbix']['agent']['log_file'] = '/var/log/zabbix-agent/zabbix-agentd.log'
default['zabbix']['agent']['debug_level'] = nil # default (3)
default['zabbix']['agent']['server_ip'] = '127.0.0.1'
