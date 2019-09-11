#
# Cookbook Name:: apache
# Recipe:: server
#
# Copyright (c) 2019 The Authors, All Rights Reserved

# notifies :action, 'resource[name]', :timer
# subscribes :action, 'resource[name]', :timer
# :before, :delayed, :immediately

package 'httpd' do
  action :install
end

#cookbook_file 'var/www/html/index.html' do
#  source 'index.html'
#end

remote_file '/var/www/html/sampleimage.png' do
  source 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStJPNXzPh6wobPYQELFzKCqq96KSY9-1lYzv9ftYWYi7PpsFtDQA'
end


template '/var/www/html/index.html' do
  source 'index.html.erb'
  action :create
#  notifies :restart, 'service[httpd]', :immediately
  action :create
end

bash "inline script" do 
  user "root"
  code "mkdir -p /var/www/mysites/ && chown -R apache /var/www/mysites/"
  not_if do
   File.directory?('/var/www/mysites/')
  end
end

execute "run a script" do
  user "root"
  command <<-EOH
  mkdir -p /var/www/mysites/
  chown -R apache /var/www/mysites/
  EOH
  
  
end

#execute "run script" do
 # user "root"
  #command './myscript.sh'
  #not_if
#end

directory "/var/www/mysites" do
  owner 'apache'
  recursive true
  mode
end


service 'httpd' do
  action [:enable, :start]
  subscribes :restart, 'template[/var/www/html/index.html]', :immediately
end

