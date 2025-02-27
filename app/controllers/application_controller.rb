class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_dashboard_path : buyer_dashboard_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end

