class Buyer::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_buyer

  def new
    @plan = Plan.find(params[:plan_id])
  end

  def checkout
    @plan = Plan.find(params[:plan_id])
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
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
      success_url: buyer_dashboard_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: buyer_dashboard_url,
      metadata: {
        user_id: current_user.id,
        plan_id: @plan.id
      }
    )
    
    redirect_to session.url, allow_other_host: true
  rescue Stripe::StripeError => e
    redirect_to buyer_dashboard_path, alert: "Stripe error: #{e.message}"
  end

  def destroy
    subscription = current_user.subscriptions.find(params[:id])
    
    if subscription.active?
      subscription.update!(active: false)
      redirect_to buyer_dashboard_path, notice: 'Subscription cancelled successfully'
    else
      redirect_to buyer_dashboard_path, alert: 'You are not subscribed to this plan.'
    end
  end

  private
  def authorize_buyer
    redirect_to root_path unless current_user.buyer?
  end
  
end
