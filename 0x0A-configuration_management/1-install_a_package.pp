# This manifest installs Flask globally using the APT package manager.

package { 'python3-flask':
  ensure => installed,
}

exec { 'verify_flask_installation':
  command => '/usr/bin/flask --version',
  path    => ['/usr/bin', '/bin'],
  onlyif  => '/usr/bin/which flask',
  require => Package['python3-flask'],
}
