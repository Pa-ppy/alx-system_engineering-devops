# This manifest installs Flask version 2.1.0 in a virtual environment.
package { 'python3-venv':
  ensure => installed,
}

exec { 'create_virtualenv':
  command => '/usr/bin/python3 -m venv /opt/myenv',
  creates => '/opt/myenv',
  require => Package['python3-venv'],
}

exec { 'install_flask':
  command => '/opt/myenv/bin/pip install Flask==2.1.0',
  path    => ['/usr/bin', '/bin', '/opt/myenv/bin'],
  require => Exec['create_virtualenv'],
}
