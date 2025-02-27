class Invoice < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :subscription
  belongs_to :plan

  enum status: { pending: 'pending', paid: 'paid', overdue: 'overdue' }
  after_create :send_invoice

  def send_invoice
    InvoiceMailer.send_invoice(self).deliver_now
  end
end
