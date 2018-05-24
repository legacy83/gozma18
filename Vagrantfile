Vagrant.configure("2") do |config|
    # Ubuntu 18.04 - Bionic Beaver
    config.vm.define "ubuntu18" do |ubuntu18|
        ubuntu18.vm.box = "bento/ubuntu-18.04"
        ubuntu18.vm.hostname = "gozma18"
        ubuntu18.vm.network "private_network", ip: "192.168.27.18"
        # provisioners
        config.vm.provision 'shell', path: './vagrant/provision/once-as-root.sh'
        config.vm.provision 'shell', path: './vagrant/provision/once-as-vagrant.sh', privileged: false
        config.vm.provision 'shell', path: './vagrant/provision/always-as-root.sh', run: 'always'
        # post-install message (vagrant console)
        config.vm.post_up_message = "App URL: http://gozma18.local"
    end
end
