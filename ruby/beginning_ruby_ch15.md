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

