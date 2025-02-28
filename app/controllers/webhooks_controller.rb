class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  
  def stripe
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    event = nil
  
    begin
      event = Stripe::Webhook.construct_event(
        payload, 
        sig_header, 
        ENV['STRIPE_WEBHOOK_SECRET']
      )
    rescue JSON::ParserError, Stripe::SignatureVerificationError
      head :bad_request
      return
    end
    case event.type
    when 'invoice.finalized'
      # handle_invoice_finalized(event.data.object)
    when 'checkout.session.completed'
      handle_checkout_session_completed(event.data.object)
    end
  
    head :ok
  end
  
  private

  def handle_invoice_finalized(invoice)
    buyer = User.find_by(stripe_customer_id: invoice.customer, role: 'buyer')
    if buyer
      InvoiceMailer.with(buyer: buyer, invoice: invoice).send_invoice_deliver_now
    end
  end  
  
  def handle_checkout_session_completed(session)
    buyer = User.find_by(id: session.metadata.user_id)
    plan = Plan.find_by(id: session.metadata.plan_id)

    if buyer && plan
      subscription = buyer.subscriptions.create!(
        plan: plan,
        billing_day: Date.today.day,
        active: true
      )
    end
    invoice = Stripe::Invoice.retrieve(session.invoice)
    Invoice.create!(stripe_invoice_id: invoice.id, buyer_id: buyer.id, plan_id: plan.id, subscription_id: subscription.id, total_amount: invoice.total, status: invoice.status, billing_period: invoice.period_start..invoice.period_end )
  end
end
