class Admin::UsageController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @usages = Usage.includes(:buyer, :feature, :subscription).all
  end

  private
  def authorize_admin
    redirect_to root_path unless current_user.admin?
  end
end
