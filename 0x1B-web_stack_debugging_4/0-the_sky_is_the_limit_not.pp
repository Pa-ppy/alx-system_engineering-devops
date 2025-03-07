# This Puppet manifest adjusts the web stack (Nginx) to handle 1000 requests with 100 concurrent requests without failures.

# Increase file descriptor limits system-wide
file { '/etc/security/limits.conf':
    ensure  => present,
    content => "
* soft nofile 65536
* hard nofile 65536
",
    notify  => Exec['reload-pam-limits'],
}

# Reload PAM limits to apply changes
exec { 'reload-pam-limits':
    command     => 'pam_limits.so',
    path        => '/usr/lib/x86_64-linux-gnu/security/',
    refreshonly => true,
}

# Update Nginx configuration to handle more concurrent connections
file { '/etc/nginx/nginx.conf':
    ensure  => present,
    content => "
events {
    worker_connections 4096;
}

http {
    client_body_buffer_size 10K;
    proxy_buffer_size 128k;
    error_log /var/log/nginx/error.log debug;
}
",
    notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
    ensure => running,
    enable => true,
}
