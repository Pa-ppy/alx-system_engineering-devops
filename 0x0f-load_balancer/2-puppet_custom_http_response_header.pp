# 2-puppet_custom_http_response_header.pp
# This Puppet script configures Nginx with a custom HTTP header X-Served-By

class nginx_custom_header {
    package { 'nginx':
        ensure => installed,
    }

    service { 'nginx':
        ensure => running,
        enable => true,
    }

    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => template('nginx/default.erb'),
        notify  => Service['nginx'],
    }

    file { '/etc/nginx/templates/default.erb':
        ensure  => file,
        content => @("EOF")
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm;
    server_name _;
    location / {
        add_header X-Served-By $hostname;
    }
}
| EOF
        notify  => Service['nginx'],
    }
}
