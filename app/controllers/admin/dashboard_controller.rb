class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
        @buyers = User.where(role: 'buyer')
    end

    private

    def authorize_admin
        redirect_to root_path unless current_user.admin?
    end
end
