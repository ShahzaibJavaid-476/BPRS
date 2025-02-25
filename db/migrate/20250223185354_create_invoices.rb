class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :subscription, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.string :stripe_invoice_id
      t.integer :amount_due
      t.string :status
      t.date :due_date

      t.timestamps
    end
  end
end
