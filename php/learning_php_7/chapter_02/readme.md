# Chapter 2 - Web Applications with PHP

* HTTP and how web apps make use of it
* How to build a simple web app
* Web servers and how to launch your PHP built-in web server

## HTTP Protocol

> The goal is to allow two entities or nodes to communicate with each other

HTTP is stateless; it treats each request independently, unrelated to any previous one.

## Web Servers

A web server is no more than a piece of software running on a machine and listening to requests from a specific port.

The job of a web server is to route external requests to the correct application so that they can be processed. Once the application returns a response, the web server will send this response to the client. Let's take a close look at all the steps:

1. The client, which is a browser, send a a request. This might be, `GET`, `POST`, `PATCH`, `DELETE`
2. The server receives the request, which points to a port. if there's a web server listening to the port, the webs erver will then take control of the situation
3. The web server decides which web application needs to process the request.
4. The web application, after receiving a request from the web server, generates a reponse and sends it to the web server.
5. The web server sends the response to the indicated port
6. The response finally arrives to the client

## The PHP built-in server

* We can use webservers that support high loads of traffic such as *Apache* or *Nginx*
* We'll be using the PHP built-in server
* Creating our first web page


```php
<? php
echo 'hello world';
```

```bash
$ php -S localhost:8000
```

* `php -S` starts a web server and listens to port `8000` instead of port `80`
* PHP knows that the web application code will be on the same directory that you started the web server
By default, PHP will try to execute the `index.php` file in the directory that you start the web server

