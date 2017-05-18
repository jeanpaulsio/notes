This will be a brief discussion about TDD'ing my Recipient and Message endpoints.

```
Recipients
GET    api/v1/recipients
POST   api/v1/recipients
GET    api/v1/recipients/:id
PUT    api/vi/recipients/:id
DELETE api/vi/recipients/:id

Messages
POST   api/v1/messages
```

# Testing Recipient Endpoints

Let's think about what a recipient is within the context of this app. A recipient belongs to a user. Thus, in order to set up our tests, we will most likely need a user object and a recipient object. Beyond that, we will also need some kind of authorization because a user should only be able to query against their own recipients. We'll handle all of this inside our setup when we test our `RecipientsController`

First we need to create some fixtures - a user and a couple of recipients

```yaml
# test/fixtures/users.yml

michael:
  uid: michael@test.com
  name: Michael
  email: michael@test.com
  encrypted_password: <%= User.new.send(:password_digest, 'foobar') %>
```

```yaml
# test/fixtures/recipients.yml
jim:
  name: jim
  email: jim@test.com
  phone: "9496405333"
  twitter_handle: wuphfwuphf
  facebook_id: wuphfwuphf
  user: michael

dwight:
  name: dwight
  email: dwight@test.com
  phone: "9496405333"
  twitter_handle: wuphfwuphf
  facebook_id: wuphfwuphf
  user: jim
```

We have a user, `:michael` and two recipients. While `:jim` is one of Michael's recipients, `:dwight` is not. This will be useful for testing to see whether or not a user can access a recipient who does not belong to them. With that said, let's dive into our setup

```ruby
require 'test_helper'

class Api::V1::RecipientsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user              = users(:michael)
    @recipient         = recipients(:jim)
    @invalid_recipient = recipients(:dwight)
    @auth_headers      = @user.create_new_auth_token

    get new_api_v1_user_session_path, headers: @auth_headers
  end
end
```

Devise Token Auth comes with a handy method called `create_new_auth_token` that is useful for testing. Before each call, we're able to create the appropriate tokens and pass them through the headers of each request.

# GET api/v1/recipients

The first endpoint that we'll test against will be for grabbing a user's index of recipients. First, we want to make sure that that a user must be authorized and logged-in to see an index of recipients.

```ruby
test "recipient routes require authorization" do
  get api_v1_recipients_path, headers: {}
  assert_equal 401, status
  assert_match /Authorized users only/, @response.body
end
```

I anticipate testing all of my endpoints to require authorization and so I will include all assertions in this method. Getting this test to pass is as easy as including a single line in our `ApiController`

```
before_action :authenticate_api_v1_user!
```

Now that we're green, we can test to make sure that an index of recipients is properly returned when a user is authenticated.

```ruby
  test "GET api/v1/recipients" do
    get api_v1_recipients_path, headers: @auth_headers,
                                xhr: true

    assert_equal 200, status
    assert_equal "application/json", @response.content_type
  end
```

Let's break this test down, as the structure will be repeated for most of the other tests as well.

1. We call the endpoint: `api_v1_recipients_path`
2. Pass in the correct headers that we requested inside of our `setup`
3. Assert that the status is 200 OK
4. Assert that we get a json response back

__Going Green__

First, let's write a helper method that will give us back a json response

```ruby
# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end

# app/controllers/api/v1/api_controller.rb

# ...
include Response
# ...

```
We can then make use of this helper method inside of our controllers

```ruby
class Api::V1::RecipientsController < Api::V1::ApiController
  respond_to :json
  before_action :set_user

  # GET api/v1/recipients
  def index
    @recipients = @user.recipients
    json_response(@recipients)
  end

  private

    def set_user
      @user = current_user
    end
end
```

And we're green!

# POST api/v1/recipients

For the POST endpoint, we'll write tests that send valid parameters and invalid parameters.

First we make sure that only an authorized user can send a post request - and so we append to our first test:

```
post api_v1_recipients_path, headers: {}
assert_equal 401, status
assert_match /Authorized users only/, @response.body
```

Because of the line, `before_action :authenticate_api_v1_user!`, we already know that this test will pass. We can continue by writing tests that send valid and invalid parameters.

```ruby
def setup
  # ...
  @valid_params   = { name: "Jim", email: "jim@test.com", phone: "9091234567" }
  @invalid_params = { name: "Jim", email: "jim@test.com", phone: "invalid" }
end

test "POST api/v1/recipients with valid params" do
  assert_difference 'Recipient.count', 1 do
    post api_v1_recipients_path, params: @valid_params,
                                 headers: @auth_headers,
                                 xhr: true
  end

  assert_equal 201, status
  assert_equal "application/json", @response.content_type
end

test "POST api/v1/recipients with invalid params" do
  assert_no_difference 'Recipient.count' do
    post api_v1_recipients_path, params: @invalid_params,
                                 headers: @auth_headers,
                                 xhr: true
  end

  assert_equal 422, status
  assert_match /Validation failed/, @response.body
  assert_equal "application/json", @response.content_type
end
```

In our first test, we send `@valid_params` along with our request and assert that the number of Recipients in our database will increase by 1. In our second test, we assert that the number of Recipients in our database will note increase and also that the response body will include 'Validation Failed'.

__Going Green__

```ruby

  # POST api/v1/recipients
  def create
    @recipient = @user.recipients.create!(recipient_params)
    json_response(@recipient, :created)
  end

  private

    def recipient_params
      params.permit(:name, :email, :phone, :twitter_handle, :user_id)
    end
```

I've chosen to use the bang method on `create` instead of implementing a flow control with if-statements. On the web app implementation, our flow control says that if a `recipient` does not save, we will redirect the user back with a friendly error message. Given the nature of API's, I'm going to suggest using the bang method, `create!` along with exceptions that return a 400 error.

If we run our tests now, the first one passes but the second one throws an error as expected

```
  test_PUT_api/v1/recipients/:id_with_valid_params        PASS (0.15s)
  test_POST_api/v1/recipients_with_invalid_params         ERROR (0.14s)

  ActiveRecord::RecordInvalid:         ActiveRecord::RecordInvalid: Validation failed: Phone is invalid
```

To fix this, we add to our ExceptionHandler and include it along with our `Concerns` instead of our `ApiController`

```ruby
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end

```

# GET api/v1/recipients/:id

No surprise, our first test for this endpoint begins by making sure a user is authorized

```
get api_v1_recipient_path(@recipient), headers: {}
assert_equal 401, status
assert_match /Authorized users only/, @response.body
```

Next, the two tests we will simulate getting a single recipient successfully as well as getting a recipient who does not belong to the user. The latter case should return null as we don't want users to be able to access another persons recipients. In the context of this app, this would mean that a user might be able to access someone who isn't in their Dog Pack.

```ruby
  test "GET api/v1/recipients/:id" do
    get api_v1_recipient_path(@recipient), headers: @auth_headers,
                                           xhr: true

    assert_equal 200, status
    assert_equal "application/json", @response.content_type
  end

  test "GET api/v1/recipients/:id with another user's recipient" do
    get api_v1_recipient_path(@invalid_recipient), headers: @auth_headers,
                                                   xhr: true

    assert_equal 200, status
    assert_equal "null", @response.body
  end
```

In order to make sure that recipients belong to a user, we will make use of the `current_user` method that comes with Devise

```ruby
  before_action :set_recipient, only: [:show]

  # GET api/v1/recipients/:id
  def show
    json_response(@recipient)
  end

  private

    def set_recipient
      @recipient = current_user.recipients.find_by(id: params[:id])
    end
```

# PUT api/v1/recipients/:id

As always, we need to make sure that a user is authenticated

```
patch api_v1_recipient_path(@recipient), headers: {}
assert_equal 401, status
assert_match /Authorized users only/, @response.body
```

Then we test updating a recipient with both valid and invalid parameters

```ruby
  test "PUT api/v1/recipients/:id with valid params" do
    new_name = "Jimmy"

    patch api_v1_recipient_path(@recipient), headers: @auth_headers,
                                             xhr: true,
                                             params: { name: new_name }

    assert_equal 200, status
    @recipient.reload
    assert_equal new_name, @recipient.name
  end

  test "PUT api/v1/recipients/:id with invalid params" do
    new_phone = "invalid phone number"

    patch api_v1_recipient_path(@recipient), headers: @auth_headers,
                                             xhr: true,
                                             params: { phone: new_phone }

    assert_equal 200, status
    @recipient.reload
    assert_not_equal new_phone, @recipient.phone
  end
```

The first test will change the recipient's name to "Jimmmy" and make sure it persists to the database. The second test will attempt to save an invalid phone number. Because tests have already been written around the `Recipient` model, we don't have to worry about validating the phone number format - just that it doesn't persist to the database.

To get the tests to pass, we'll make sure to set the recipient before the `update` method as well

```ruby
  before_action :set_recipient, only: [:show, :update]

  # PUT api/v1/recipients/:id
  def update
    @recipient.update(recipient_params)
    json_response(@recipient)
  end
```

# DELETE api/v1/recipients/:id

We're almost there. This endpoint will be quick -

```
delete api_v1_recipient_path(@recipient), headers: {}
assert_equal 401, status
assert_match /Authorized users only/, @response.body
```

```ruby
  test "DELETE api/v1/recipients/:id" do
    assert_difference 'Recipient.count', -1 do
      delete api_v1_recipient_path(@recipient), headers: @auth_headers,
                                                xhr: true
    end

    assert_equal 204, status
  end
```

All we have to do is test to make sure that there is one less recipient in the database after calling the DELETE endpoint. To get this test to pass, we write:

```ruby
  before_action :set_recipient, only: [:show, :update, :destroy]

  #DELETE api/v1/recipients/:id
  def destroy
    @recipient.destroy
    head :no_content
  end
```

Here, the `set_recipient` method makes sure that a user is deleting their own recipient

# Testing Messages

The messages will only be testing one endpoint but there are three edge cases to consider

1. sending a message with valid parameters
2. sending a message with invalid parameters
3. sending a message to an invalid recipient (a recipient who does not belong to the user)

These tests look like this:

```ruby
require 'test_helper'

class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user              = users(:michael)
    @recipient         = recipients(:jim)
    @invalid_recipient = recipients(:dwight)
    @auth_headers      = @user.create_new_auth_token

    get new_api_v1_user_session_path, headers: @auth_headers

    @valid_params = {
      content: "michael to jim",
      user_id: @user.id,
      recipient_id: @recipient.id
    }
    @invalid_params = {
      content: "",
      user_id: @user.id,
      recipient_id: @recipient.id
    }
    @invalid_recipient_params = {
      content: "michael to dwight",
      user_id: @user.id,
      recipient_id: @invalid_recipient.id
    }

  end

  test "POST api/v1/messages with valid params" do
    assert_difference 'Message.count', 1 do
      post api_v1_messages_path, params: @valid_params,
                                 headers: @auth_headers,
                                 xhr: true
    end

    assert_equal 201, status
    assert_equal "application/json", @response.content_type
  end

  test "POST api/v1/messages with invalid params" do
    assert_no_difference 'Message.count' do
      post api_v1_messages_path, params: @invalid_params,
                                 headers: @auth_headers,
                                 xhr: true
    end

    assert_equal 422, status
    assert_match /Validation failed/, @response.body
    assert_equal "application/json", @response.content_type
  end

  test "POST api/v1/messages with invalid recipient" do
    assert_no_difference 'Message.count' do
      post api_v1_messages_path, params: @invalid_recipient_params,
                                 headers: @auth_headers,
                                 xhr: true
    end

    assert_equal 404, status
    assert_match /Couldn't find Recipient/, @response.body
    assert_equal "application/json", @response.content_type
  end
end
```

To get these tests to pass is fairly simple

```ruby
class Api::V1::MessagesController < Api::V1::ApiController
  # POST api/v1/messages
  def create
    @message = current_user.messages.create!(message_params)
    SendWuphf.new(@message).execute unless @message.nil?
    json_response(@message, :created)
  end

  private
    def message_params
      params.permit(:content, :user_id, :recipient_id)
    end
end
```

WHEW - Up next, I'll be discussing a React-Native implementation and how I'm using objects instead of arrays to manage my state in Redux.
