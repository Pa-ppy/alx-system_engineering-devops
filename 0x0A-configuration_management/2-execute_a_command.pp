# This manifest kills a process named "killmenow" using the pkill command.
exec { 'kill killmenow':
  command     => '/usr/bin/pkill killmenow',
  path        => ['/usr/bin', '/bin', '/usr/sbin', '/sbin'],
  onlyif      => '/usr/bin/pgrep killmenow',
  refreshonly => false,
}
