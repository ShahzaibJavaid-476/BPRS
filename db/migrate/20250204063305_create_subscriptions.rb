class CreateSubscriptions < ActiveRecord::Migration[7.2]
  def change
    create_table :subscriptions do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :plan, null: false, foreign_key: true
      t.integer :billing_day
      t.boolean :active
      t.string :default
      t.string :true

      t.timestamps
    end
  end
end
