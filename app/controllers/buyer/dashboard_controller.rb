class Buyer::DashboardController < BuyerController
  
  def index
    @plans = Plan.includes(:features)
  end    
end

