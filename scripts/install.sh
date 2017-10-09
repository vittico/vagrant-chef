#!/bin/bash -eux

yum -v -d 6 -y update

yum -v -d 6 -y groupinstall Base
yum -v -d 6 -y groupinstall Core
yum -v -d 6 -y groupinstall Development Tools

yum -v -d 6 -y install openssl-devel readline-devel zlib-devel kernel-devel vim wget curl rsync 
yum -v -d 6 -y install git  python-setuptools gcc sudo libffi-devel python-devel epel-release unzip nfs-utils nfs-utils-lib
yum -v -d 6 -y update

yum clean all

mkdir -p /home/vagrant/.ssh
curl -L -k 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -o /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh


wget https://packages.chef.io/files/stable/chefdk/2.3.4/el/6/chefdk-2.3.4-1.el6.x86_64.rpm
wget https://packages.chef.io/files/stable/chef-server/12.16.14/el/6/chef-server-core-12.16.14-1.el6.x86_64.rpm

rpm -Uvh chefdk-2.3.4-1.el6.x86_64.rpm
rpm -Uvh chef-server-core-12.16.14-1.el6.x86_64.rpm

chef-server-ctl reconfigure
chef-server-ctl user-create admin Chef Sysop test@test.local '12345678' --filename admin.pem
chef-server-ctl org-create test 'Test Limited Co.' --association_user admin --filename test-validator.pem


chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license

sudo chef-server-ctl test
