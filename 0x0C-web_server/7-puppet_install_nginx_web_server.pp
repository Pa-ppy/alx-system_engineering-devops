# Install and configure Nginx with a 301 redirect

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
