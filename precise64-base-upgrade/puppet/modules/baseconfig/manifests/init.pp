# == Class: baseconfig
#
# Performs initial configuration tasks for Debian boxes
#
class baseconfig {

	# update repositories
	exec { "apt-get update":
		command => "apt-get update";
	}

	# install base packages
	package { [ "build-essential",
							"curl",
							"git",
							"vim",
							"zsh"
						]:
		ensure => present,
		require => Exec["apt-get update"];
	}

	host { "hostmachine":
		ip => "192.168.0.1";
	}
}