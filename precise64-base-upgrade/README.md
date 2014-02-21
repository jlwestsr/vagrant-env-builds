# Precise64 Base Box Upgrade

This project will be for building an updated version of the Vagrant's Ubuntu Precise64 (12.04-x86_64) box. This box is the standard base box with a few additional installed/upgraded packages listed below.

1. build-essential
2. curl
3. git
4. vim
5. zsh
6. puppet (3.4.3)
7. chef (11.10.4)
8. VirtualBox Guest Addons (4.3.6) 

## Box Build Location(s) by Build Dates

1. 2014-02-21
	* precise64-base-20140221.box

### Example Use

```sh
$ vagrant box add precise64-base-20140221 http://cdn.jlwestsr.com/vagrant/boxes/precise64-base-20140221.box
```
and/or define in the VagrantFile as

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby

# Vagrantfile API/sysntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box 		= "precise64-base-20140221"
	config.vm.box_url = "http://cdn.jlwestsr.com/vagrant/boxes/precise64-base-20140221.box"
end
```

## Vagrant Plugins Installed (Host)

1. vagrant-cachier (0.5.1)
2. vagrant-vbguest (0.10.0)
3. vagrant-vbox-snapshot (0.0.4)

## The Upgrade Process

### Actions performed on host machine (Host)

```sh
$ vagrant init
$ # modified Vagrantfile on host machine
$ vagrant up
$ vagrant ssh
```

### Actions performed on precise64 box (VM)

```sh
$ sudo apt-get -y upgrade
$ exit # exit out of ssh session
```
NOTES: During the process of the upgrade the grub-pc prompted for interaction:

```sh
GRUB install devices:
	[*] /dev/sda (85899 MB; VBOX_HARDDISK)
	[ ] - /dev/sda1 (254 MB; /boot)
	[ ] /dev/dm-0 (84833 MB; precise64-root)
```

### Actions peformed on host machine post-upgrade (Sanity Check) (Host -> VM)

```sh
$ vagrant halt
$ vagrant up
$ vagrant ssh
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get autoremove
$ sudo apt-get autoclean
```

### Install Puppet (3.4.3) (VM)

```sh
$ wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
$ sudo dpkg -i puppetlabs-release-precise.deb
$ sudo apt-get update
$ sudo apt-get -y install puppet
$ sudo rm -Rf puppetlabs-release-precise.deb
```

### Install Chef (11.10.4) (VM)

```sh
$ sudo curl -L https://www.opscode.com/chef/install.sh | sudo bash
```

### Packaging for vagrant box (Host)

```sh
$ vagrant package --base precise64-upgrade-20140221 --output precise64-base-20140221.box
```

### OUTSTANDING ISSUES

* Still seeing messages with VirtualBox Guest Addons update.