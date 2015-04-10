
#$loglevel = 'warn'
$loglevel = 'debug'

package { 'apache2':
  ensure => present,
}

file { '/etc/apache2/apache2.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '00644',
  content => template('apache2.conf.erb'),
  require => Package['apache2'],
}

service { 'apache2':
  ensure    => running,
  require   => Package['apache2'],
  subscribe => File['/etc/apache2/apache2.conf']
}
