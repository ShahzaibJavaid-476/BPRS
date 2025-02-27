class Buyer::PlansController < BuyerController
  
  def index
    @plans = Plan.all
  end  
end
