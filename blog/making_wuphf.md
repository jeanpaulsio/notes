* A lot of the logic lives in the `DemoWuphfsController#create`
* The home page has a form so that users can send a demo wuphf out to friends
* As you can see from the logic, if a form is successfully submitted, an email, text message, and tweet are sent out

```ruby
def create
  @demo_wuphf = DemoWuphf.new(demo_wuphf_params)

  if @demo_wuphf.save
    WuphfMailer.wuphf_mail(@demo_wuphf).deliver_now
    TwilioWrapper.new(@demo_wuphf).send
    TwitterWrapper.new(@demo_wuphf).send

    flash[:success] = "WUPHF WUPHF! YOU HAVE SENT A WUPHF!"
    redirect_to new_demo_wuphf_path
  else
    render 'new'
  end
end
```

* Here we have PORO's created for `TextMessage` and `Tweet`

```ruby
class TwitterWrapper
  def initialize(options = {})
    @twitter_handle = options.twitter_handle
    @message        = options.message

    boot_twitter
  end

  def send
    @client.update("@" + @twitter_handle + " " + @message)
  end

  private

    def boot_twitter
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end
end
```

```ruby
class TwilioWrapper
  def initialize(options = {})
    @message = options.message
    @phone   = options.phone
    @from    = options.from

    boot_twilio
  end

  def send
    @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: @phone,
      body: "#{@from.upcase} WUPHF'D: " + @message
    )
  end

  private

    def boot_twilio
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new account_sid, auth_token
    end
end

```

```
├── app
│   ├── controllers
│   │   └── demo_wuphfs_controller.rb
│   ├── models
│   │   └── demo_wuphf.rb
│   │   └── twilio_wrapper.rb
│   │   └── twitter_wrapper.rb
```

* but it kind of feels weird that we have wrappers for twilio and twitter inside of our models folder, right?
* maybe we can make this sexier and more granular
* I'm going to propose that we structure out and make some minor refactor adjustments

```
├── app
│   ├── adapters
│   │   └── twilio_wrapper.rb
│   │   └── twitter_wrapper.rb
│   ├── controllers
│   │   └── demo_wuphfs_controller.rb
│   ├── models
│   │   └── demo_wuphf.rb
│   ├── services
│   │   └── send_demo_wuphf.rb
```

* First we move our `Tweet` and `TextMessage` into an adapters folder
* Then we create a services folder and specify a service called `send_demo_wuphf`
* Our controller eventually becomes pretty sexy

```ruby
  def create
    @demo_wuphf = DemoWuphf.new(demo_wuphf_params)

    if @demo_wuphf.save
      SendDemoWuphf.new(@demo_wuphf).execute

      flash[:success] = "WUPHF WUPHF! YOU HAVE SENT A WUPHF!"
      redirect_to new_demo_wuphf_path
    else
      render 'new'
    end
  end
```

* Pretty skinny right?
