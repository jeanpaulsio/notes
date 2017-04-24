we have a partial for that lets a user input a coupon code before inputting their credit card information when they book a session

Here is a the view

```erb
<% if current_user %>
  <div class="info-box">
    <% @coupon = Coupon.new %>
    <%= form_for @coupon do |f| %>
      <%= f.hidden_field :user_id, :value => current_user.id %>
        <% if @coordinator.stripe_coupon %>
           <label><%= @coordinator.stripe_coupon.id %> (<%=  @coordinator.coupon_discount %>)</label>
        <% end %>
        <div class='input-group'>
          <%= f.text_field :stripe_id, class: 'form-control', placeholder: "#{ @coordinator.stripe_coupon ? 'Update Promo Code' : 'Promo Code'}", value: "#{@coordinator.stripe_coupon ? @coordinator.stripe_coupon.id : nil }", :required => true %>
          <span class="input-group-btn">
            <%= f.submit "#{ @coordinator.stripe_coupon ? 'Update' : 'Save'}", class:'btn btn-info btn-block' %>
          </span>
        </div>
    <% end %>
  </div>
<% end %>
```

Now you're probably thinking, woah, code smells! JP - your views should be dumb! And to that I would say, "hey, we had to ship something!"

And also, "refactoring can be fun"

a lot of this business logic lives in our user model

```ruby

# app/models/user.rb

 def coupon_percent_off
    if  self.stripe_coupon['percent_off'] != nil
      self.stripe_coupon['percent_off'].to_s + "%" + " Off"
    end
  end

  def coupon_amount_discount
    if  self.stripe_coupon['amount_off'] != nil
      "$" + (self.stripe_coupon['amount_off'].to_i / 100).to_s + " Off"
    end
  end

  def coupon_discount
    if self.coupon_percent_off
      self.coupon_percent_off
    elsif self.coupon_amount_discount
      self.coupon_amount_discount
    end
  end

  def coupon_valid?
    if self.stripe_coupon['valid'] == true
      nil
    elsif self.stripe_coupon['valid'] == false
      "No Longer Valid"
    end
  end


  def stripe_coupon_id
    customer = Stripe::Customer.retrieve(self.stripe_id)
    coupons = customer['discount']['coupon']['id']
  end


  def stripe_coupon
    customer = Stripe::Customer.retrieve(self.stripe_id)
    if customer['discount'] == nil
      false
    else
      coupons = customer['discount']['coupon']
    end
    rescue
    false
  end

```

Benchmarks:

Before

Rendered coordinators/_new_promocode.html.erb (4283.7ms)
Rendered coordinators/_new_promocode.html.erb (2621.4ms)
Rendered tutoring_sessions/new.html.erb within layouts/application (8608.3ms)

Rendered coordinators/_new_promocode.html.erb (3844.2ms)
Rendered coordinators/_new_promocode.html.erb (2656.4ms)
Rendered tutoring_sessions/new.html.erb within layouts/application (8215.6ms)



After
Rendered coordinators/_new_promocode.html.erb (6.4ms)
Rendered coordinators/_new_promocode.html.erb (0.9ms)
Rendered tutoring_sessions/new.html.erb within layouts/application (496.2ms)

Rendered coordinators/_new_promocode.html.erb (7.9ms)
Rendered coordinators/_new_promocode.html.erb (0.9ms)
Rendered tutoring_sessions/new.html.erb within layouts/application (499.3ms)

