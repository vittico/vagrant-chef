#
# Cookbook:: my_tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute 'update_yum_caches' do
        command 'yum -v -d 6 -y update'
end

execute 'base_packages' do
        command 'yum -v -d 6 -y groupinstall Base'
end

execute 'base_packages' do
        command 'yum -v -d 6 -y groupinstall Core'
end

package 'wget'
package 'curl'
package 'rsync'
package 'git'

package 'java-1.8.0-openjdk'
package 'java-1.8.0-openjdk-devel'

file '/etc/environment' do
	content ::File.open("/home/vagrant/vagrant-chef/chef/my_tomcat/templates/default/environment.rb").read
end

execute 'download_tomcat' do
        command 'wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.23/bin/apache-tomcat-8.5.23.tar.gz -O /tmp/tomcat.tgz'
end

group 'tomcat' do
end

user 'tomcat' do
  home '/opt/tomcat8'
  shell '/bin/bash'
  group 'tomcat'
  manage_home true
  action :create
end

execute 'create_tomcat_dir' do
        command 'mkdir -p /opt/tomcat8'
end

execute 'untar_tomcat' do
        command 'tar xzf /tmp/tomcat.tgz -xC /tmp/'
end

execute 'copy_tomcat_distrib' do
        command 'cp -rv /tmp/apache-tomcat-8.5.23/* /opt/tomcat8'
end

execute 'adjust_security' do
        command 'chown -R tomcat:tomcat /opt/tomcat8'
end

execute 'adjust_executables' do
        command 'chmod +x /opt/tomcat8/bin/*.sh'
end

file '/etc/init.d/tomcat' do
        content ::File.open("/home/vagrant/vagrant-chef/chef/my_tomcat/templates/default/tomcat.rb").read
	owner 'root'
	group 'root'
	mode '0755'
end

file '/opt/tomcat8/conf/jmxremote.access' do
        content ::File.open("/home/vagrant/vagrant-chef/chef/my_tomcat/templates/default/jmxremote.access.rb").read
	owner 'tomcat'
	group 'tomcat'
	mode '0755'
end

file '/opt/tomcat8/conf/jmxremote.password' do
        content ::File.open("/home/vagrant/vagrant-chef/chef/my_tomcat/templates/default/jmxremote.password.rb").read
        owner 'tomcat'
        group 'tomcat'
        mode '0600'
end

file '/opt/tomcat8/bin/setenv.sh' do
        content ::File.open("/home/vagrant/vagrant-chef/chef/my_tomcat/templates/default/setenv.sh.rb").read
        owner 'tomcat'
        group 'tomcat'
        mode '0755'
end

execute 'start_tomcat' do
	command 'service tomcat restart'
end

execute 'enable_tomcat' do
	command '/sbin/chkconfig --add tomcat'
end
