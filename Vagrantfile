Vagrant.configure("2") do |config|
  # Ubuntu 18.04 - Bionic Beaver
  config.vm.define "ubuntu18" do |ubuntu18|
    ubuntu18.vm.box = "bento/ubuntu-18.04"
    ubuntu18.vm.hostname = "gozma18"
    ubuntu18.vm.network "private_network", ip: "192.168.27.18"
    # provisioners
    ubuntu18.vm.provision 'shell', path: './vagrant/provision/provision-01--common.sh'
    ubuntu18.vm.provision 'shell', path: './vagrant/provision/provision-02--webserver.sh'
    ubuntu18.vm.provision 'shell', path: './vagrant/provision/provision-03--databases.sh'
    ubuntu18.vm.provision 'shell', path: './vagrant/provision/provision-04--extras.sh'
    ubuntu18.vm.provision 'shell', path: './vagrant/provision/provision-05--cleanup.sh'
    # synced folders
    ubuntu18.vm.synced_folder '.', '/vagrant', disabled: true
    ubuntu18.vm.synced_folder '~/PhpStorm__Projects', '/projects', owner: 'vagrant', group: 'vagrant'
    # configuration
    ubuntu18.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
  end
end
