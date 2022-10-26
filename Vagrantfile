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
  config.vm.network "forwarded_port", guest: 22, host: 2022
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
	h.mac = "00:00:00:00:00:1d"
	h.enable_checkpoints = false
    h.enable_virtualization_extensions = true
    h.enable_enhanced_session_mode = true
    h.vmname = "vagrant-dev"
  end

  ###########################################################
  #
  # Configure
  #
  config.vm.provision "shell", inline: <<-SHELL
    curl -fsSL https://raw.githubusercontent.com/jehon/packages/main/start | bash -E -
	apt update && apt install -y jehon-packages jehon-hardware-hyperv jehon-systeme-vm
  SHELL
end
