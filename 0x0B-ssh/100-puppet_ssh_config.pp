# This Puppet manifest configures SSH client settings for passwordless login

file { '/etc/ssh/ssh_config':
  ensure  => file,
  content => "Host *\n  IdentityFile ~/.ssh/school\n  PasswordAuthentication no\n",
  mode    => '0644',
}
