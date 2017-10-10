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

template '/etc/init.d/tomcat' do
  source 'tomcat.rb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/opt/tomcat8/conf/jmxremote.access' do
  source 'jmxremote.access.rb'
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
end

template '/opt/tomcat8/conf/jmxremote.password' do
  source 'jmxremote.password.rb'
  owner 'tomcat'
  group 'tomcat'
  mode '0600'
end

template '/opt/tomcat8/bin/setenv.sh' do
  source 'setenv.sh.rb'
  owner 'tomcat'
  group 'tomcat'
  mode '0755'
end

execute 'start_tomcat' do
        command 'service tomcat restart'
end
