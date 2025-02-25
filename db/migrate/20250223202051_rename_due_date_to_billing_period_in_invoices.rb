class RenameDueDateToBillingPeriodInInvoices < ActiveRecord::Migration[7.2]
  def change
    rename_column :invoices, :due_date, :billing_period
  end
end
