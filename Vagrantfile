# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "grig" do |grig_box|
    grig_box.vm.box_url = "http://ergonlogic.com/files/boxes/debian-LAMP-current.box"
    grig_box.vm.box = "grig"
    grig_box.vm.network :private_network, ip: '192.168.22.2'
    grig_box.vm.hostname = "grig.ru"
    grig_box.vm.provider "virtualbox" do |v|
       v.customize ["modifyvm", :id,
         "--memory", "1024"
       ]
    end
  end
end
