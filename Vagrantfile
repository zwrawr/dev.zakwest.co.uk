# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
    
    config.vm.box = "ubuntu/bionic64"
    
    config.vm.network "private_network", ip: "192.168.48.48"
    
    config.vm.synced_folder "www.zakwest.tech", "/var/www/www.zakwest.tech", :mount_options => ["dmode=777", "fmode=776"]
    #config.vm.synced_folder ".", "/vagrant", owner: "vagrant", group: "vagrant"

    config.ssh.forward_agent = true
    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 2
    end
    
    config.vm.provision "shell", path: "provision.sh"
    
end
