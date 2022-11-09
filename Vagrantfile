# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  ###########################################################
  #
  # VM
  #
  #  @see Boxes at https://vagrantcloud.com/search.
  #
  config.vm.provider "hyperv"
  config.vm.box = "generic/debian11"
  config.vm.hostname = "vagrant-dev"

  ###########################################################
  #
  # Disks
  #
  #  @see https://www.vagrantup.com/docs/disks/configuration
  #  @see https://www.vagrantup.com/docs/disks/hyperv/usage
  #
  config.vm.disk :disk, primary: true, size: "80GB", Fixed: true

  ###########################################################
  #
  # Network
  #
  config.vm.network "public_network", bridge: "Default Switch"
  # config.vm.network "forwarded_port", host: 2022, host_ip: "127.0.0.1", guest: 22, guest_ip: "127.0.0.1", protocol: "tcp"
  # config.vm.synced_folder "../data", "/vagrant_data"

  ## SSH
  # config.ssh.private_key_path
  # config.ssh.forward_x11 = true

  ###########################################################
  #
  # hyperv specific
  #
  #  @see https://www.vagrantup.com/docs/providers/hyperv/configuration
  #
  config.vm.provider "hyperv" do |h|
    h.auto_start_action = "StartIfRunning"
    h.cpus = 2
    h.memory = 4096
    h.maxmemory = 8192
	h.mac = "00:00:00:00:00:1f"
	h.enable_checkpoints = false
    h.enable_virtualization_extensions = true
    h.enable_enhanced_session_mode = true
    h.vmname = config.vm.hostname
  end

  ###########################################################
  #
  # Provisionner
  #
  #    vagrant provision --provision-with sshkey
  #
  #  @see https://developer.hashicorp.com/vagrant/docs/provisioning/basic_usage
  #

  #  @See docs.vagrantup.com/v2/provisioning/file.html
  config.vm.provision "sshkey", type: "file", source: "#{ENV["USERPROFILE"]}/.ssh/id_rsa", destination: "/home/vagrant/.ssh/"
	
  config.vm.provision "sshkey-install", type: "shell", inline: <<-SHELL
    mkdir -p /root/.ssh
	cp -r /home/vagrant/.ssh/id_rsa /root/.ssh/id_rsa
	chmod 600 -R /root/.ssh
  SHELL
    
  config.vm.provision "packages", type: "shell", inline: <<-SHELL
    set -o errexit
	adduser --shell /bin/bash jehon
	curl -fsSL https://raw.githubusercontent.com/jehon/packages/main/start | bash -E -
	apt update
	DEBIAN_FRONTEND=noninteractive apt install -y jehon-packages jehon-desktop jehon-hardware-hyperv jehon-os-debian jehon-system-vm
	reboot
  SHELL

  ###########################################################
  #
  # Locally
  #
  #  @see https://developer.hashicorp.com/vagrant/docs/triggers/configuration
  #
  IP="fe80::200:ff:fe00:1f"

  config.trigger.after [:up, :destroy ] do |trigger|
    trigger.name = "SSH cleanup"
	trigger.info = "forget key"

	trigger.run = { inline: "ssh-keygen -R #{IP}" }
	trigger.on_error = :continue
  end

  config.trigger.after :up do |trigger|
    trigger.name = "SSH add"
	trigger.info = "Update the local known_hosts"

	trigger.run = { inline: "ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new jehon@#{IP} echo 'ok' " }
	trigger.on_error = :continue
  end 
end
