class CreatePlans < ActiveRecord::Migration[7.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :monthly_fee

      t.timestamps
    end
  end
end
