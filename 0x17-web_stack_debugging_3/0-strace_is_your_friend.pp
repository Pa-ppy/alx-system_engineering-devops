# This Puppet manifest fixes Apache's 500 error by ensuring necessary permissions and missing modules are configured.

class apache_fix {
    # Ensure Apache is installed and enabled
    package { 'apache2':
        ensure => installed,
    }

    service { 'apache2':
        ensure    => running,
        enable    => true,
        require   => Package['apache2'],
    }

    # Fix missing or incorrect permissions for /var/www/html
    file { '/var/www/html':
        ensure  => directory,
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '0755',
    }

    # Ensure the required PHP module is enabled
    exec { 'enable_php_module':
        command => '/usr/sbin/a2enmod php7.0',
        unless  => '/usr/sbin/a2query -m php7.0',
        notify  => Service['apache2'],
    }

    # Restart Apache to apply changes
    exec { 'restart_apache':
        command => '/etc/init.d/apache2 restart',
        refreshonly => true,
        subscribe   => Exec['enable_php_module'],
    }
}

include apache_fix
