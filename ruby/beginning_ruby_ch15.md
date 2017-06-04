# Chapter 15 - Networking and Sockets

## Networking Concepts
* a network is just a group of computers that are connected in some way
* networking is the overall concept of communications between two or more computers or devices

## TCP and UDP
* __TCP/IP__ is the collective name for two network protocols: Transmission Control Protocol and Internet Protocol
* _TCP_: defines the concept of computers connecting to one another. it makes sure packets of data are transmitted and successfully received by machines in correct order
* _IP_: concerned with the actual routing of data from one machine to another
* IP is the base of most local networks and the Internet. TCP sits on top and makes the connection reliable
* _UDP_: user datagram protocol. isn't considered reliable and it doesn't ensure that data is sent

## IP Address and DNS
* a machine on an IP-based network has one or many IP addresses
* when you visit a website, your computer first asks a Domain Name Service (DNS) server for the IP address associated with the host's name
  - then, when it gets the raw address, your web browser will make a connection to that machine on port 80

## Basic Network Operations

__Checking machine and service availability__

* one of the most basic network operations you can perform is a _ping_ - a simple check that another machine is available on the network or that a service it offers is available

```ruby
require 'net/ping'

if Net::Ping::External.new('google.com', 80).ping
  puts "Pong"
else
  puts "No Response"
end
```

* what's happening here?
  - in this instance, you connect directly to google's HTTP port as if you were a web browser
  - once you get a connection, it immediately disconnects

__Performing DNS Queries__

* most networking libraries allow you to specify domain names and hostnames when you want to interact with a remote server and automatically resolve these names into IP address
* this adds some overhead
* sometimes you might want to resolve IP addresses ahead of time
* you can use DNS queries to check for the existence of different hostnames and to check whether a domain is active or not, even if its not pointing to a web server

```ruby
require 'resolv'

puts Resolv.getaddress("www.jeanpauls.io")

```

__connecting to a tcp server directly__

* an important networking operation is to connect to a service offered by another machine and interacting with it in some way.
* its possible to connect directly to a remote service at the TCP level and talk to them in their raw format
* we can use the net/telnet library to connect to a website and retrieve a web page using HTTP protocol directly

```ruby
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
```

* what's happening here?
  - Net::Telnet connects to rubyinside.com on port 80
  - Then, it issues these commands: "GET /test.txt HTTP1.1" on the host rubyinside.com
  - these commands are part of the HTTP protocol

## Servers and Clients
Clients connect to servers. Servers process information and manage connections and data being received from and sent to the clients


__UDP Client and Server__

* we can create a basic client/server system using UDP. Remember that UDP has no concept of connections and so it doesn't make sure that messages are successfully passed. TCP/IP is like making a phone call whereas UDP is like sending a postcard

Server:

```ruby
require 'socket'

s = UDPSocket.new
s.bind(nil, 1234)
5.times do
  text, sender = s.recvfrom(16)
  puts text
end
```

* this uses the _socket_ library and binds a server to port 1234 on the local machine

Client:

```ruby
require 'socket'

s = UDPSocket.new
s.send("hello", 0, "localhost", 1234)

```

* this code creates a UDP socket. instead of listening for data, it sends the string "hello" to the UDP server on localhost at port 1234
* if you run the client and the server together, "hello" should appear where the server.rb file is running
* congrats, you have successfully sent data across a network
