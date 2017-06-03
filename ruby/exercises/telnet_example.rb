require 'net/telnet'

server = Net::Telnet::new('Host' => 'www.rubyinside.com',
                          'Port' => 80,
                          'Telnetmode' => false)

server.cmd("GET /test.txt HTTP/1.1\nHost: www.rubyinside.com\n") do |response|
  puts response
end


=begin
HTTP/1.1 200 OK
Date: Sat, 03 Jun 2017 23:19:11 GMT
Server: Apache/2.2.22 (Ubuntu)
Last-Modified: Sun, 15 Oct 2006 01:24:13 GMT
ETag: "1210ab-1d-41fcf61012940"
Accept-Ranges: bytes
Content-Length: 29
Vary: Accept-Encoding
Content-Type: text/plain
X-Pad: avoid browser bug

Hello Beginning Ruby reader!
=end
