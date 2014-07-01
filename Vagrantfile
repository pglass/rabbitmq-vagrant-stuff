# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "Ubuntu_14_04"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.define "rabbit1" do |rabbit1|
    rabbit1.vm.hostname = 'rabbit1'
    rabbit1.vm.network :private_network, ip: "192.168.33.10"
    rabbit1.vm.box = "Ubuntu_14_04"

    rabbit1.vm.provision 'shell' do |s|
      s.inline = 'sudo bash -c \'echo "192.168.33.11 rabbit2"\' >> /etc/hosts'
      s.privileged = 'true'
    end
  end
  config.vm.define "rabbit2" do |rabbit2|
    rabbit2.vm.hostname = 'rabbit2'
    rabbit2.vm.network :private_network, ip: "192.168.33.11"
    rabbit2.vm.box = "Ubuntu_14_04"

    rabbit2.vm.provision 'shell' do |s|
      s.inline = 'sudo bash -c \'echo "192.168.33.10 rabbit1"\' >> /etc/hosts'
      s.privileged = 'true'
    end
  end

  config.vm.provision :file do |file|
    file.source      = 'sources.list'
    file.destination = '/home/vagrant/sources.list'
  end
  config.vm.provision :file do |file|
    file.source      = 'start_node.sh'
    file.destination = '/home/vagrant/start_node.sh'
  end
  config.vm.provision :file do |file|
    file.source      = 'rabbitmq.config'
    file.destination = '/home/vagrant/rabbitmq.config'
  end
  config.vm.provision :file do |file|
    file.source      = '.erlang.cookie'
    file.destination = '/home/vagrant/.erlang.cookie'
  end
  config.vm.provision 'shell' do |s|
     s.path = "setup.sh"
     s.privileged = false
  end
  config.vm.provision :file do |file|
    file.source      = 'vimrc'
    file.destination = '/home/vagrant/.vimrc'
  end
  config.vm.provision 'shell' do |s|
    s.inline = 'echo "set background=dark" >> /home/vagrant/.vimrc'
  end
  
  # config.vm.provision 'shell', inline: 'sudo apt-get install git vim python'

  # config.vm.provision 'shell', inline: 'echo "Vagrant: Setting up vim..."'
  # config.vm.provision :file do |file|
  #   file.source      = '~/.vimrc'
  #   file.destination = '/home/vagrant/.vimrc'
  # end
  # config.vm.provision 'shell' do |s|
  #   s.inline = 'echo "set background=dark" >> /home/vagrant/.vimrc'
  #   s.inline = 'mkdir -p ~/.vim/bundle'
  #   s.inline = 
  # end

end
