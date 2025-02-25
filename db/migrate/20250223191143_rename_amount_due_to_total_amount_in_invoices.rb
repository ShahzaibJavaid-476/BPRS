class RenameAmountDueToTotalAmountInInvoices < ActiveRecord::Migration[7.2]
  def change
    rename_column :invoices, :amount_due, :total_amount
  end
end
