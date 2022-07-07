# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # config.vm.provider "hyperv"
  
  # Boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2110"
  config.vm.hostname = "dev"
  # config.vm.disk :disk, primary: true, size: "40GB"
  
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.synced_folder "../data", "/vagrant_data"


  config.vm.provider "hyperv" do |h|
	# https://www.vagrantup.com/docs/providers/hyperv/configuration#enable_enhanced_session_mode
    h.cpus = 2
	h.enable_virtualization_extensions = true
	h.enable_enhanced_session_mode = true
	h.linked_clone = true
	h.memory = 4096
	h.maxmemory = 4096
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    curl -fsSL https://raw.githubusercontent.com/jehon/packages/main/start | bash -E -
  SHELL
end
