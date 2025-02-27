class Buyer::SubscriptionsController < BuyerController

  def new
    @plan = Plan.find(params[:plan_id])
  end

  def checkout
    @plan = Plan.find(params[:plan_id])
    session = Subscriptions::CheckoutService.new(current_user, @plan).call
    redirect_to session.url, allow_other_host: true
  rescue  Stripe::StripeError => e
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
end

