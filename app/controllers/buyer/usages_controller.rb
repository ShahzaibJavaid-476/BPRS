class Buyer::UsagesController < BuyerController

  def create 
    @feature = Feature.find(params[:feature_id])
    @subscription = current_user.subscriptions.find_by(id: params[:subscription_id], active: true)
    if @subscription
      @usage = Usage.find_or_initialize_by(buyer_id: current_user.id, subscription_id: @subscription.id, feature_id: @feature.id)
      @usage.units_used = (@usage.units_used || 0) + params[:units_used].to_i
      @usage.save!
      redirect_to buyer_dashboard_path, notice: 'Feature used successfully'
    else
      redirect_to buyer_dashboard_path, alert: 'You must have active subscription to use this feature'
    end
  end
end

