class Buyer::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_buyer

=begin
    def subscribe
        plan = Plan.find(params[:plan_id])
        current_user.plans << plan unless current_user.subscribed_to?(plan)  # Add the plan if not already subscribed
        redirect_to buyer_dashboard_path, notice: "Subscribed to #{plan.name}!"
    end
    
    def unsubscribe
        plan = Plan.find(params[:plan_id])
        current_user.plans.delete(plan)  # Remove the plan from subscriptions
        redirect_to buyer_dashboard_path, notice: "Unsubscribed from #{plan.name}."
    end
=end

  private
  def authorize_buyer
    redirect_to root_path unless current_user.buyer?
  end
  
end
