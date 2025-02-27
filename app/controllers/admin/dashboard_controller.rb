class Admin::DashboardController < AdminController
  
  def index
    @buyers = User.buyer
  end
end

