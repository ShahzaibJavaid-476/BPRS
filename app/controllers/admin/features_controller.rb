class Admin::FeaturesController < AdminController
  before_action :set_feature, only: [:edit, :update, :destroy]
  before_action :set_plans, only: [:new, :create, :edit, :update] 
   
  def index
    @features = Feature.all
  end

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(feature_params)

    if @feature.save
      redirect_to admin_features_path, notice: 'Feature was successfully created.'
    else
      flash[:notice] = 'Feature could not be created'
      render :new
    end
  end

  def edit 
  end

  def update
    if @feature.update(feature_params)
      redirect_to admin_features_path, notice: 'Feature was successfully updated.'
    else
      flash[:notice] = 'Feature could not be updated'
      render :edit
    end
  end

  def destroy
    @feature.destroy
    redirect_to admin_features_path, notice: 'Feature was successfully deleted.'
  end

  private
  def feature_params
    params.require(:feature).permit(:name, :code, :unit_price, :max_unit_limit, :plan_id)
  end
  def set_feature
    @feature = Feature.find(params[:id])
  end    
  def set_plans
    @plans = Plan.all
  end       
end

