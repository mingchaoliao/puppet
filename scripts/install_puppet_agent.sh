sudo apt-get update
sudo apt-get install -y wget
cd /tmp
wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt-get update
sudo apt-get install -y puppet-agent
