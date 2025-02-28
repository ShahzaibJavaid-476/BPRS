class Admin::UsageController < AdminController

  def index
    @usages = Usage.includes(:buyer, :feature, :subscription).all
  end
end
