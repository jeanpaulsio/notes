require 'net/ping'

if Net::Ping::External.new('google.com', 80).ping
  puts "Pong"
else
  puts "No Response"
end
