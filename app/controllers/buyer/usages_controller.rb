class Buyer::UsagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_buyer

  def create 
    @feature = Feature.find(params[:feature_id])
    @subscription = current_user.subscriptions.find_by(id: params[:subscription_id], active: true)
    if @subscription
      @usage = Usage.find_or_initialize_by(buyer_id: current_user.id, subscription_id: @subscription.id, feature_id: @feature.id)
      @usage.units_used = (@usage.units_used || 0) + params[:units_used].to_i
      @usage.save!
      redirect_to buyer_dashboard_path, notice: 'Feature used successfully'
    else
      redirect_to buyer_dashboard_path, alert: 'You must have active susbcription to use this feature'
    end
  end

  private
  def authorize_buyer
    redirect_to root_path unless current_user.buyer?
  end
end
