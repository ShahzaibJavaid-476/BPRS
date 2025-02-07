class Admin::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  def index
    @subscriptions = Subscription.includes(:buyer, :plan).all
  end
  def new
    @subscription = Subscription.new
  end
  def create
    @subscription = Subscription.new(subscription_params)

    if @subscription.save
      redirect_to admin_subscriptions_path, notice: 'Subscription was successfully created.'
    else
      flash[:notice] = "Subscription could not be created"
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @subscription.update(subscription_params)
      redirect_to admin_subscriptions_path, notice: 'Subscription was successfully updated.'        
    else
      render :edit            
    end
  end
  def destroy    
    @subscription.destroy
    redirect_to admin_subscriptions_path, notice: 'Subscription was successfully deleted.'
  end    

  private
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end    
  def subscription_params         
    params.require(:subscription).permit(:buyer_id, :plan_id, :billing_day, :active)        
  end 
  def authorize_admin
    redirect_to root_path unless current_user.admin?
  end
end
