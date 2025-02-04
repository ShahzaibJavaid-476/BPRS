class CreateFeatures < ActiveRecord::Migration[7.2]
  def change
    create_table :features do |t|
      t.string :name
      t.string :code
      t.decimal :unit_price
      t.integer :max_unit_limit
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
