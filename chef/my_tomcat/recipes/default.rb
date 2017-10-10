#
# Cookbook:: my_tomcat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'my_tomcat::update_yum_cache'
include_recipe 'my_tomcat::install_base_packages'
include_recipe 'my_tomcat::install_core_packages'
include_recipe 'my_tomcat::install_extra_packages'
include_recipe 'my_tomcat::install_jdk_packages'
include_recipe 'my_tomcat::setup_environment_vars'
include_recipe 'my_tomcat::download_install_tomcat'
