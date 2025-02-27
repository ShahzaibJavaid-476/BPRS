class Admin::BuyersController < AdminController
    
  def index
  end

  def new
    @buyer = User.new
  end

  def create
    @buyer = User.new(buyer_params)
    @buyer.buyer!

    if @buyer.save
      UserMailer.invitation_email(@buyer).deliver_now
      redirect_to admin_dashboard_path, notice: 'Buyer added and invitation sent!'
    else
      render :new
    end
  end

  def edit
    @buyer = User.find(params[:id])
  end

  def update
    @buyer = User.find(params[:id])

    if @buyer.update(buyer_params)
      redirect_to admin_dashboard_path, notice: 'Buyer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @buyer = User.find(params[:id])
    
    if @buyer.destroy
      redirect_to admin_buyers_path, notice: 'Buyer was successfully deleted.'
    else
      redirect_to admin_buyers_path, alert: 'There was an error deleting the buyer.'
    end
  end
  
  private  
  def buyer_params
    params.require(:user).permit(:name, :email, :password)
  end
end

  