# Fixes Apache 500 error by correcting a typo in wp-settings.php if the file exists
exec { 'fix_wp_settings':
  command => '/bin/sed -i "s/phpp/php/g" /var/www/html/wp-settings.php',
  onlyif  => '/bin/test -f /var/www/html/wp-settings.php',
}
