# -*- mode: ruby -*-
# vi: set ft=ruby :

vm_name = "jhodev"

Vagrant.configure("2") do |config|
  config.vm.provider "hyperv"
  
  # Boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2110"
  
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  config.vm.network "public_network", bridge: "Default Switch"
  config.vm.network "public_network", bridge: "J Internal 192.168.100.1", ip: "192.168.100.2"
  config.vm.hostname = vm_name

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "hyperv" do |h|
	# https://www.vagrantup.com/docs/providers/hyperv/configuration#enable_enhanced_session_mode
    h.cpus = 2
	h.enable_virtualization_extensions = true
	h.enable_enhanced_session_mode = true
	h.linked_clone = true
	h.memory = 4096
	h.maxmemory = 4096
	h.vmname = vm_name
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
  SHELL
end
