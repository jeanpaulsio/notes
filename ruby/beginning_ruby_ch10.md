# Chapter 10 - Distributing Ruby Code and Libraries

## The Shebang Line
* On a UNIX-related operating system, you can engineer your program to run more simply by using a *shebang line*

```ruby
# some_file.rb

#!/usr/bin/ruby

puts "program contents here"
```

* UNIX-related operating systems support putting the name of the interpreter of a file on the first line of a file with a shebang line
* in this case, `/usr/bin/ruby` is the Ruby interpreter that is used to interpret the rest of the file

## Detection of OS with RUBY_PLATFORM

```ruby
if RUBY_PLATFORM =~ /win32/
  puts "We're in Windows!"
elsif RUBY_PLATFORM =~ /linux/
  puts "We're in Linux!"
elsif RUBY_PLATFORM =~ /darwin/
  puts "We're in Mac OS X!"
elsif RUBY_PLATFORM =~ /freebsd/
  puts "We're in FreeBSD!"
else
  puts "We're running under an unknown operating system."
end
```

# Generic HTTP Servers
## WEBrick

* WEBrick is a Ruby library that makes it easy to build an HTTP server with ruby
* here is a basic HTTP server

```ruby
require 'webrick'

server = WEBrick::GenericServer.new( :Port => 1234 )
trap("INT"){ server.shutdown }

server.start do |socket|
  socket.puts Time.now
end
```

... and a more complex one that uses servlets

```ruby
require 'webrick'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    response.status       = 200
    response.content_type = "text/plain"
    response.body         = "Hello, world"
  end

  server = WEBrick::HTTPServer.new( :Port => 1234 )
  server.mount "/", MyServlet
  trap("INT"){ server.shutdown }
  server.start
end
```

* if we visit `localhost:1234` we will see the output of "Hello, world"
