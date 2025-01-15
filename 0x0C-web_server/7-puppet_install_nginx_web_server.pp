# Installs and configures Nginx server with a 301 redirect and custom index page

exec { 'install_nginx':
  provider => shell,
  command  => '
    sudo apt-get update -y &&
    sudo apt-get install -y nginx &&
    echo "Hello World!" | sudo tee /var/www/html/index.html &&
    sudo sed -i "s/server_name _;/server_name _;\n\trewrite ^\/redirect_me https:\/\/example.com permanent;/" /etc/nginx/sites-available/default &&
    sudo systemctl start nginx &&
    sudo systemctl enable nginx
  ',
}

# Ensures Nginx is listening on port 80
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.conf.erb'),
}

# Ensures Nginx is configured correctly to listen on port 80
service { 'nginx':
  ensure => running,
  enable => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
