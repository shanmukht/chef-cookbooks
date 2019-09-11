package 'emacs'

package 'tree' do
  action :install
end

package 'git' do
  action :install
end

package 'ntp'

# print statement 'I have 4 apples'
apple_count = 4
puts "I have #{apple_count} apples"

template '/etc/motd' do
 source 'motd.erb' 
 variables(
  :name => 'shamukh' 
 )
 action :create
end

user 'user1' do
  comment 'user1'
  uid '123'
  home '/home/user1'
  shell '/bin/bash'
end

group 'admins' do
  members 'user1'
  append true
end

