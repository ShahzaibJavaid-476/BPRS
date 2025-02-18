class AddBuyerIdToUsages < ActiveRecord::Migration[7.2]
  def change
    add_reference :usages, :buyer, null: false, foreign_key: {to_table: :users}
  end
end
