class InvoiceMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def send_invoice(invoice)
    @invoice = invoice
    @buyer = invoice.buyer
    mail(to: @buyer.email, subject: 'Your Invoice is ready')
  end    
end
