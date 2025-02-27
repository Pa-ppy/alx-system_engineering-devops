# Fixes Apache 500 error by correcting a typo in wp-settings.php
exec { 'fix_wp_settings':
  command  => 'sed -i "s/phpp/php/g" /var/www/html/wp-settings.php',
  provider => shell,
}
