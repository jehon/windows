# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 2.3.1"

VMName = "vm-dev"
IP = "fe80::ff:fe00:1f"
MAC = "02:00:00:00:00:01"

HOME = ENV["USERPROFILE"]

def fileMustExist(fn) 
  if File.exist?(fn) then
    STDOUT.puts("Ok, file #{fn} is found")
    return
  end

  STDERR.puts("ABORTED! You need #{fn} file")
  exit(false)
end

fileMustExist("#{HOME}/.ssh/ansible-key.txt")
fileMustExist("#{HOME}/.ssh/id_rsa")

Vagrant.configure("2") do |config|
  ###########################################################
  #
  # VM
  #
  #  @see Boxes at https://vagrantcloud.com/search.
  #
  config.vm.provider "hyperv"
  config.vm.box = "generic/debian11"
  config.vm.hostname = VMName

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
	h.mac = MAC
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

  config.vm.provision "packages", type: "shell", inline: <<-SHELL
    set -o errexit
    curl -fsSL https://raw.githubusercontent.com/jehon/packages/main/start | bash -E -
  SHELL

  config.vm.provision "user-jehon", type: "shell", inline: <<-SHELL
    set -o errexit
	  useradd --create-home --shell /bin/bash jehon
  SHELL

  #  @See docs.vagrantup.com/v2/provisioning/file.html
  config.vm.provision "sshkey",  type: "file", source: "#{HOME}/.ssh/id_rsa", destination: "/home/vagrant/.ssh/"
  config.vm.provision "firefox", type: "file", source: "#{HOME}/AppData/Roaming/Mozilla/Firefox", destination: "/home/vagrant/.mozilla/firefox"

  config.vm.provision "install", type: "shell", inline: <<-SHELL
    mkdir -p /root/.ssh
    [ -r /home/vagrant/.ssh/id_rsa ] && mv /home/vagrant/.ssh/id_rsa /root/.ssh/id_rsa
    chmod 600 -R /root/.ssh

    mkdir -p /home/jehon/.mozilla/firefox
	  [ -r /home/vagrant/firefox ] && mv /home/vagrant/firefox /home/jehon/.mozilla/firefox
    chown jehon:jehon -R /home/jehon/.mozilla/firefox
  SHELL
 
  ###########################################################
  #
  # Locally
  #
  #  @see https://developer.hashicorp.com/vagrant/docs/triggers/configuration
  #
  # We use "dev" as hostname, since this will be the new host name
  # "dev" is defined in ssh config, and updated by startup script, so it is good
  #

  config.trigger.after [:up, :destroy ] do |trigger|
    trigger.name = "SSH cleanup"
	  trigger.info = "forget key"
  	trigger.run = { inline: "ssh-keygen -R dev" }
  	trigger.on_error = :continue
  end

  config.trigger.after :up do |trigger|
    trigger.name = "SSH add"
	  trigger.info = "Update the local known_hosts"
  	trigger.run = { inline: "ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new root@dev echo 'ok' " }
  	trigger.on_error = :continue
  end 
end
