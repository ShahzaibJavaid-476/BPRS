module Subscriptions
  class CheckoutService
    def initialize(user, plan)
      @user = user
      @plan = plan
    end

    def call
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: @user.email,
        line_items: [{
          price_data: {
            currency: 'usd',
            product_data: { name: @plan.name },
            unit_amount: (@plan.monthly_fee * 100).to_i,
            recurring: { interval: 'month' }
          },
          quantity: 1
        }],
        mode: 'subscription',
        expand: ['invoice'],
        success_url: "#{ENV['NGROK_URL']}/buyer/dashboard?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: "#{ENV['NGROK_URL']}/buyer/dashboard",
        metadata: {
          user_id: @user.id,
          plan_id: @plan.id
        }
      )

      @user.subscriptions.create!(
        plan: @plan,
        billing_day: Date.today.day,
        active: true
      )  
      session
    end
  end
end
