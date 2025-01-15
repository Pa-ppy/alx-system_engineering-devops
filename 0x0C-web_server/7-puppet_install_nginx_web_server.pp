# Install and configure Nginx with a 301 redirect and ensure it returns 200 OK at the root

exec { 'install_nginx':
  provider => shell,
  command  => '
    sudo apt-get update -y &&
    sudo apt-get install -y nginx &&
    echo "Hello World!" | sudo tee /var/www/html/index.html &&
    sudo sed -i "s|server_name _;|server_name _;\n  location /redirect_me { return 301 https://www.example.com; }|" /etc/nginx/sites-available/default &&
    sudo systemctl start nginx &&
    sudo systemctl enable nginx
  ',
}

# Ensure Nginx is listening on port 80
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
    server {
      listen 80 default_server;
      listen [::]:80 default_server;

      root /var/www/html;
      index index.html;

      server_name _;

      # Serve the root page with "Hello World!"
      location / {
        try_files $uri $uri/ =404;
      }

      # Redirect /redirect_me with a 301 Moved Permanently
      location /redirect_me {
        return 301 https://www.example.com;
      }
    }',
  notify  => Service['nginx'],  # Restart Nginx if config changes
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  subscribe => File['/etc/nginx/sites-available/default'],  # Restart Nginx if config file changes
}
