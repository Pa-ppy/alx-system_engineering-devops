# Fixes Apache 500 error by correcting a typo in wp-settings.php if the file exists
exec { 'fix_wp_settings':
  command  => 'sed -i "s/phpp/php/g" /var/www/html/wp-settings.php',
  provider => shell,
  onlyif   => 'test -f /var/www/html/wp-settings.php',
}
