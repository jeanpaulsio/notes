Recreating WUPHF: Finishing The Web App - Part 2

At the end of my [last post](https://medium.com/@jeanpaulsio/recreating-wuphf-with-rails-pt-1-c36809825217), I had just finished my MWP - Minimum Wuphfable Product. That is, guests are able to send a Wuphf without registering. To flesh out this app's functionality, I want users to be able to sign in. Signed in users are able to create, manage, and save their own contacts. They will be able to Wuphf their contacts directly as well as tweet them from their own Twitter account. Note that sending a demo-wuphf as a guest will ping the recipient of the Wuphf from the @wuphfwuphf twitter account instead of their own.

## Planning The Data Structure

Thinking about the data structure to add user sign ins, I will need 3 models: `Messages`, `Recipients`, and `Users`

```
Users - A registered user
Has Many Recipients
Has Many Messages
email:string
password:string
```

```
Recipients - A resource created by a user, much like a contact in your phone book. Recipients are the receivers of a user's Wuphf
Belongs To User
name:string
email:string
phone:string
twitter_handle:string
```

```
Messages - The Wuphf itself
Belongs To User
Belongs To Recipient
content:string
```

## Connecting Twitter

One of the bigger challenges I faced was adding the ability for a user to send tweets on their own behalf. Let's take a look at how DemoWupfs are sending tweets.

Twitter is booted and initialized like so:

```ruby
    def initialize
      boot_twitter
    end

    def boot_twitter(token, secret)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end
```

The problem with this is that the `access_token` and `access_token_secret` are specific to the @wuphfwuphf twitter account. There needs to be some way for a registered user to generate their own tokens. When the twitter client boots, it should use **their own** tokens instead of the environment variable ones.

My solution for this is to set default parameters when booting twitter to the environment variables. This lets guests still tweet from @wuphfwuphf when they are sending a demo. But now I am calling `boot_twitter` with `token` and `secret` parameters so that when a user generates their own tokens, I can pass them in and authenticate their account.

```ruby
    def initialize(token=ENV['TWITTER_ACCESS_TOKEN'], secret=ENV['TWITTER_ACCESS_TOKEN_SECRET'])
      boot_twitter(token, secret)
    end

    def boot_twitter(token, secret)
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = token
        config.access_token_secret = secret
      end
    end
```

## Better UX

Excited about what I made, I showed a couple of friends my web app and the one thing that I noticed was that they didn't know that they could send a Wuphf without signing up for an account. They thought that the form that is used to send a Wuphf was a registration form! And who wants to have to register for something just to try something out? The problem was that people didn't know that they could send a Wuphf just from the home screen as a new user

In an effort to make it more clear that the home page was not a registration form, I restructured the layout.


Recreating WUPHF: Creating the API - Part 3
Recreating WUPHF: Managing Redux State with Objects - Part 4
