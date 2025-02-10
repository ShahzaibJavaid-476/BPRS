class CreateUsages < ActiveRecord::Migration[7.2]
  def change
    create_table :usages do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :feature, null: false, foreign_key: true
      t.integer :units_used

      t.timestamps
    end
  end
end
