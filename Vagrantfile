Vagrant.configure("2") do |config|
    # Ubuntu 18.04 - Bionic Beaver
    config.vm.define "ubuntu18" do |ubuntu18|
        ubuntu18.vm.box = "bento/ubuntu-18.04"
        ubuntu18.vm.hostname = "gozma18"
        ubuntu18.vm.network "private_network", ip: "192.168.27.18"
        # provisioners
        config.vm.provision 'shell', path: './vagrant/provision/provision-common.sh'
        config.vm.provision 'shell', path: './vagrant/provision/provision-webserver.sh'
        config.vm.provision 'shell', path: './vagrant/provision/provision-databases.sh'
        # config.vm.provision 'shell', path: './vagrant/provision/provision-extras.sh'
        config.vm.provision 'shell', path: './vagrant/provision/provision-cleanup.sh'
        # post-install message (vagrant console)
        config.vm.post_up_message = "App URL: http://gozma18.local"
    end
end
