# This Puppet manifest fixes Nginx configuration to handle high traffic and reduce failed requests.

# Adjust file descriptor limits
file { '/etc/security/limits.conf':
    ensure  => present,
    content => "
* soft nofile 65536
* hard nofile 65536
",
    notify  => Exec['reload-pam-limits'],
}

exec { 'reload-pam-limits':
    command     => 'pam_limits.so',
    path        => '/usr/lib/x86_64-linux-gnu/security/',
    refreshonly => true,
}

# Update Nginx configuration
file { '/etc/nginx/nginx.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "
events {
    worker_connections 1024;
}

http {
    client_body_buffer_size 10K;
    proxy_buffer_size 128k;
    error_log /var/log/nginx/error.log debug;
}
",
    notify  => Service['nginx'],
}

# Ensure Nginx service is running
service { 'nginx':
    ensure => running,
    enable => true,
}
