# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # config.vm.provider "hyperv"

  #
  # SSH
  #
  # config.ssh.private_key_path
  # config.ssh.forward_x11 = true

  #
  # VM
  #

  # Boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2204"
  config.vm.hostname = "vagrant-dev"
  config.vm.network "public_network", bridge: "Default Switch"

  # https://www.vagrantup.com/docs/disks/configuration
  # https://www.vagrantup.com/docs/disks/hyperv/usage
  # config.vm.disk :disk, primary: true, size: "40GB", Fixed: true
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.synced_folder "../data", "/vagrant_data"

  #
  # hyperv specific
  #
  config.vm.provider "hyperv" do |h|
    # https://www.vagrantup.com/docs/providers/hyperv/configuration
    h.cpus = 2
    h.enable_virtualization_extensions = true
    h.enable_enhanced_session_mode = true
    h.linked_clone = true
    h.memory = 4096
    h.maxmemory = 4096
    h.vmname = "vagrant-dev"
  end

  #
  # Configure
  #

  # config.vm.provision "shell", inline: <<-SHELL
  #   curl -fsSL https://raw.githubusercontent.com/jehon/packages/main/start | bash -E -
  # SHELL

  #
  # Interact with
  #

end
