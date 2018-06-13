## Puppet For Linux Dev Env
This puppet repo is used to help me manage my several linux dev machines. 

### Preparation

#### on Ubuntu 16.04
1. initial setting on fresh machine
```bash
cd /path/to/puppet
sudo ./scripts/ubuntu1604_init.sh
```
2. log out and login back
3. install ruby 2.4.1 and bundler
```bash
rvm install 2.4.1
gem install bundler
```
4. install required gem specified in the Gemfile and install required puppet module defined in the Puppetfile
```bash
cd path/to/puppet
bundler install
librarian-puppet install
```
5. create puppet file server mount point
```bash
mkdir -p /tmp/puppet/files
```
6. download following files
 - instantclient-basic-linux.x64-12.2.0.1.0.zip
 - instantclient-sdk-linux.x64-12.2.0.1.0.zip
 - sqldeveloper-18.1.0.095.1630-no-jre.zip
7. provisioning
```bash
cd path/to/puppet
sudo su
puppet apply --modulepath=site:modules site.pp
```
