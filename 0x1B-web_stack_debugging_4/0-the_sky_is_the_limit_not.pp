# This Puppet manifest fixes the issue of high failed requests by adjusting Nginx configuration and increasing file descriptor limits.

# Increase the file descriptor limit for Nginx
exec { 'increase-nginx-ulimit':
  provider => shell,
  command  => 'sed -i "s/ULIMIT=\"-n [0-9]*\"/ULIMIT=\"-n 4096\"/" /etc/default/nginx',
  unless   => 'grep -q "ULIMIT=\"-n 4096\"" /etc/default/nginx',
}

# Restart Nginx to apply the new ULIMIT setting
exec { 'restart-nginx':
  provider => shell,
  command  => 'service nginx restart',
  require  => Exec['increase-nginx-ulimit'],
}

# Increase system-wide file descriptor limits
exec { 'increase-system-ulimit':
  provider => shell,
  command  => 'echo "* soft nofile 65536" >> /etc/security/limits.conf && echo "* hard nofile 65536" >> /etc/security/limits.conf',
  unless   => 'grep -q "* soft nofile 65536" /etc/security/limits.conf',
}

# Reload PAM limits to apply system-wide changes
exec { 'reload-pam-limits':
  provider => shell,
  command  => 'sysctl -p',
  require  => Exec['increase-system-ulimit'],
}
