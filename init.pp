class puppet {

  
  package { 'vim': ensure => 'installed' }
  package { 'curl': ensure => 'installed' }
  package { 'git': ensure => 'installed' }


  user { 'monitor':
	name	=> 'monitor',
	home	=> "/home/monitor",
	shell	=> '/bin/bash/',
  }
  
  exec{'retrieve_file':
	command => "/usr/bin/wget -q https://raw.githubusercontent.com/PearlSantos/se-exam/master/memory_check.bash -O /home/monitor/scripts/memory_check.bash",
	creates => "/home/monitor/scripts/memory_check.bash",
	
  }
  
  file { '/home/monitor/scripts/':
	ensure => 'directory',
	require => Exec["retrieve_file"],
  }
  
  file { '/home/monitor/src/':
	ensure => 'directory'
  }
  
  file{ '/home/monitor/src/my_memory_check':
	ensure => 'link',
	target => '/home/monitor/scripts/memory_check.bash",
  }
  
  cron{ 'my_memory_check':
	command => '/home/monitor/src/my_memory_check',
	minute => '*/10',
  }
	

}