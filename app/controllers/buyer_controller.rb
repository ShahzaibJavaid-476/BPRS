class BuyerController < ApplicationController
  before_action :authorize_buyer

  private
  def authorize_buyer
    redirect_to root_path, alert: 'You must be a buyer to access this page' unless current_user.buyer?
  end
end
