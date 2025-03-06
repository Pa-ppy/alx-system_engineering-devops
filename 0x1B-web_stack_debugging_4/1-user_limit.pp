# This Puppet manifest increases the file descriptor limit for the holberton user.

# Adjusting file descriptor limits for the holberton user
file { '/etc/security/limits.d/holberton.conf':
    ensure  => present,
    content => "
holberton soft nofile 65536
holberton hard nofile 65536
",
    notify  => Exec['reload-pam-limits'],
}

# Reloading PAM limits to apply changes
exec { 'reload-pam-limits':
    command     => 'pam_limits.so',
    path        => '/usr/lib/x86_64-linux-gnu/security/',
    refreshonly => true,
}
