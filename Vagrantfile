# -*- mode: ruby -*-
# vi: set ft=ruby :

# The most common configuration options are documented and commented below.
# For a complete reference, please see the online documentation at
# https://docs.vagrantup.com.
Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.synced_folder '.', '/puppet'
  config.vm.box_check_update = false

  config.vm.define 'ubuntu1604desktop', :primary => true do |box|
    box.vm.box = "learningchef/ubuntu1604-desktop"
    box.vm.network "private_network", ip: "192.168.100.1"
    config.vm.provider "virtualbox" do |v|
      v.gui = true
      v.memory = "2048"
      v.cpus = 2
    end
    config.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end
  end
end
