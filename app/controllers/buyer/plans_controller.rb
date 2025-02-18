class Buyer::PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_buyer
  def index
    @plans = Plan.all
  end

  private
  def authorize_buyer
    redirect_to root_path, alert: 'Unauthorized access. Only buyers can access this page.' unless current_user.buyer?
  end
  
end
