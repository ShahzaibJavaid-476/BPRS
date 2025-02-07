class Buyer::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_buyer
  
  def index
    @plans = Plan.includes(:features)
  end
  
  private  
  def authorize_buyer
    redirect_to root_path unless current_user.buyer?
  end
  
end  