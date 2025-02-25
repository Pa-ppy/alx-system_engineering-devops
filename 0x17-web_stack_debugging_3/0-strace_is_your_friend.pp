# Puppet manifest to fix Apache 500 error by ensuring required modules and permissions are set

class fix_apache_500 {

    # Ensure Apache is installed
    package { 'apache2':
        ensure => installed,
    }

    # Ensure PHP module is installed (required for WordPress)
    package { 'libapache2-mod-php5':
        ensure => installed,
    }

    # Ensure the correct permissions for /var/www/html
    file { '/var/www/html':
        ensure  => directory,
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '0755',
        recurse => true,
    }

    # Ensure Apache service is running and enabled
    service { 'apache2':
        ensure     => running,
        enable     => true,
        require    => Package['apache2'],
    }

    # Ensure Apache modules are enabled
    exec { 'enable-apache-php':
        command => '/usr/sbin/a2enmod php5',
        unless  => '/bin/ls /etc/apache2/mods-enabled/ | /bin/grep php5',
        notify  => Service['apache2'],
    }

    # Restart Apache to apply changes
    exec { 'restart-apache':
        command     => '/usr/sbin/service apache2 restart',
        refreshonly => true,
        subscribe   => [Package['libapache2-mod-php5'], Exec['enable-apache-php']],
    }
}

# Apply the class
include fix_apache_500
