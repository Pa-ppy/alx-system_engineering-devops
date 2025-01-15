# Install and configure Nginx to serve a custom page and setup a 301 redirect for /redirect_me

# Ensure Nginx is installed
package { 'nginx':
  ensure => installed,
}

# Configure the default Nginx site with a custom index.html and redirection
file { '/var/www/html/index.nginx-debian.html':
  ensure  => file,
  content => "Hello World!\n",  # Custom content for the root page
  notify  => Service['nginx'],  # Notify Nginx service to restart on change
}

# Modify the Nginx default site configuration to handle the redirect
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.conf.erb'),  # Ensure correct config with redirect
  notify  => Service['nginx'],  # Notify Nginx service to restart on change
}

# Ensure the Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  subscribe => File['/etc/nginx/sites-available/default'],  # Restart Nginx if config changes
}

# Redirect /redirect_me to a permanent redirect URL
file { '/etc/nginx/sites-available/default':
  content => '
    server {
      listen 80 default_server;
      listen [::]:80 default_server;
      root /var/www/html;
      index index.html index.htm;

      server_name _;

      # Redirect /redirect_me to an external URL
      location /redirect_me {
        return 301 https://www.example.com;
      }

      # Default page content
      location / {
        try_files $uri $uri/ =404;
      }
    }',
}
