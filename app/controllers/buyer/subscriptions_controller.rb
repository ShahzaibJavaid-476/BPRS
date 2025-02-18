class Buyer::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_buyer

  def new
    @plan = Plan.find(params[:plan_id])
  end

  def create
    @plan = Plan.find(params[:plan_id])

    payment = Payment.new(
      buyer_id: current_user.id,
      plan_id: @plan.id,
      amount: @plan.monthly_fee,
      status: 'success', 
      transaction_id: SecureRandom.hex(10)
    )

    if payment.save
      subscription = current_user.subscriptions.find_or_initialize_by(plan_id: @plan.id)
      subscription.update!(active: true, billing_day: Date.today.day)

      redirect_to buyer_dashboard_path, notice: 'Subscription activated successfully!'
    else
      redirect_to buyer_dashboard_path, alert: 'Payment failed! Please try again.'
    end
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
