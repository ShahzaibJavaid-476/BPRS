class Admin::PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  def index
    @plans = Plan.all
  end
  def new
    @plan = Plan.new
  end
  def create
    @plan = Plan.new(plan_params)
    @plan.monthly_fee = calculate_monthly_fee(@plan.feature_ids)
    @plan.admin = current_user

    if @plan.save
      redirect_to admin_plans_path, notice: 'Plan is successfully created.'
    else
      flash[:notice] = "Plan was not created successfully"
      render :new, status: :unprocessable_entity
    end
  end
  def show
  end
  def edit        
  end
  def update
    @plan.assign_attributes(plan_params)
    @plan.monthly_fee = calculate_monthly_fee(@plan.feature_ids)
    if @plan.save
      redirect_to admin_plans_path, notice: 'Plan is successfully updated.'
    else        
      render :edit
    end    
  end
  def destroy
    @plan.destroy
    redirect_to admin_plans_path, notice: 'Plan is successfully deleted.'
  end

  private
  def set_plan
    @plan = Plan.find(params[:id])
  end
  def plan_params
    params.require(:plan).permit(:name, feature_ids: [])
  end

  def calculate_monthly_fee(feature_ids)
    Feature.where(id: feature_ids).sum(:unit_price)
  end

  def authorize_admin
    redirect_to root_path, alert: 'Unauthorized access' unless current_user.admin?
  end
end
