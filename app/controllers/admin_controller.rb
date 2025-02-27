class AdminController < ApplicationController
  before_action :authorize_admin

  private
  def authorize_admin
    redirect_to root_path, alert: 'You must be an admin to access this page.' unless current_user.admin?
  end
end
