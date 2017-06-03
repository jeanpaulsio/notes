require 'resolv'

# puts Resolv.getaddress("www.jeanpauls.io")

ip = '151.101.24.133'

begin
  puts Resolv.getname(ip)
rescue
  puts "No hostname associated with #{ip}"
end
