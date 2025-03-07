# This Puppet manifest increases the file descriptor limit for Nginx

exec { 'increase-nginx-ulimit':
  provider => shell,
  command  => 'sed -i "s/ULIMIT=\"-n [0-9]*\"/ULIMIT=\"-n 4096\"/" /etc/default/nginx',
  unless   => 'grep -q "ULIMIT=\"-n 4096\"" /etc/default/nginx',
}

exec { 'stop-nginx':
  provider => shell,
  command  => 'service nginx stop',
  require  => Exec['increase-nginx-ulimit'],
}

exec { 'start-nginx':
  provider => shell,
  command  => 'service nginx start',
  require  => Exec['stop-nginx'],
}
