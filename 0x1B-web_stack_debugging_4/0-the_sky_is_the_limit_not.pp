# This Puppet manifest increases the file descriptor limit for Nginx

# Increase the nginx limit
exec { 'increase_nginx_ulimit':
  command  => "sed -i 's/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/g' /etc/default/nginx",
  path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
}

# Stop nginx from running
exec { 'stop_nginx':
  command  => 'service nginx stop',
  path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
}

# Start the nginx process
exec { 'start_nginx':
  command  => 'service nginx start',
  path => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  require  => Exec['stop_nginx'],
}
