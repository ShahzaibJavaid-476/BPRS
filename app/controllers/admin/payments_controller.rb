class Admin::PaymentsController < AdminController

  def index
    @payments = Payment.includes(:buyer, :plan).order(created_at: :desc)
  end
end
