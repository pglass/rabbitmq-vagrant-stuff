sudo mv /home/vagrant/sources.list /etc/apt/sources.list

echo "Vagrant: installing programs..."
sudo apt-get --assume-yes update
sudo apt-get --assume-yes install git vim python-dev python-pip rabbitmq-server

echo "Vagrant: configuring git"
git config --global user.name "Paul Glass"
git config --global user.email "paul.glass@rackspace.com"

sudo chmod +x /home/vagrant/start_node.sh

sudo service rabbitmq-server stop

sudo mv /home/vagrant/rabbitmq.config /etc/rabbitmq/rabbitmq.config
sudo mv /home/vagrant/.erlang.cookie /var/lib/rabbitmq/.erlang.cookie
sudo chown rabbitmq /var/lib/rabbitmq/.erlang.cookie
sudo chmod 600 /var/lib/rabbitmq/.erlang.cookie

sudo service rabbitmq-server start

# echo "Vagrant: installing pyenv"
# git clone git://github.com/yyuu/pyenv.git /home/vagrant/.pyenv
# # Ubuntu uses .bashrc while OS X uses .bash_profile. ZSH uses .zshenv
# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
# echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(pyenv init -)"' >> ~/.bashrc 

# echo "Vagrant: installing tox, nose, virtualenv"
# sudo pip install tox
# sudo pip install nose
# sudo pip install virtualenv
# 
# exec $SHELL
# pyenv install 2.7.7
# pyenv install 2.6.8
# 
# echo "Vagrant: setting up barbican"
# cd /home/vagrant
# virtualenv barbican
# cd barbican
# git clone https://github.com/openstack/barbican.git
# 
