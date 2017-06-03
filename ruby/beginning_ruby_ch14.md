# Chapter 14 - Ruby and the Internet

This chapter will focus on accessing and using data from the Internet. The next chapter we'll look at pinging, TCP/IP, and sockets

## HTTP and the Web
* HTTP is an Internet protocol that defines how web servers and web clients communicate with each other
* The basic principle is this, every resource on the Internet has a URL that can be used to access it
* Web clients can use HTTP verbs to retrieve and manipulate those resources: GET, POST, PUT, DELETE

```ruby
require 'net/http'

url = URI.parse('http://www.rubyinside.com/test.txt')

Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Get.new(url.path)
  puts http.request(req).body
end
```

## Checking for Errors and Redirects

```ruby
require 'net/http'

def get_web_document(url)
  uri = URI.parse(url)

  case response
  when Net::HTTPSuccess
    return response.body
  when Net::HTTPRedirection
    return get_web_document(response['Location'])
  else
    return nil
  end
end
```

## Basic Authentication

* net/http also supports basic authentication

```ruby
require 'net/http'

url = URI.parse('http://browserspy.dk/password-ok.php')

Net::HTTP.start(url.host, url.port) do |http|
  req = Net:HTTP.Get.new(url.path)
  req.basic_auth('test', 'test')
  puts http.request(req).body
end
```

## Posting Form Data

* we can also simulate filling out form data from a web page using net/http

```ruby
require 'net/http'

url = URI.parse('http://rubyinside.com/test.cgi')

response = Net::HTTP.post_form(url, { 'name' => 'JP' })
puts response.body
```

## The Open-Uri Library

* this wraps up the functionality of: net/http, net/https, net/ftp
* abstracts common Internet actions and allows file I/O techniques to be used on them

```ruby
require 'open-uri'

f = open('http://www.rubyinside.com/test.txt')
puts f.readlines.join
```


