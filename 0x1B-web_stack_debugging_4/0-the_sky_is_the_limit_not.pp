# This Puppet manifest fixes the Nginx configuration to handle high traffic and reduce failed requests.

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

service { 'nginx':
    ensure => running,
    enable => true,
}
