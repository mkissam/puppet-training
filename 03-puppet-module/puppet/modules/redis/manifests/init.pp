# --- class redis

class redis (
  $conf_template = 'redis/redis.conf.erb',
  $port = '6379',
  $redis_password = '',
) {
  package {'redis-server':
    ensure  => present,
  }

  file { '/etc/redis/redis.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    replace => true,
    content => template($conf_template),
    require => Package['redis-server'],
  }

  service { 'redis-server':
    ensure     => running,
    require    => Package['redis-server'],
    subscribe  => File['/etc/redis/redis.conf'],
  }
}