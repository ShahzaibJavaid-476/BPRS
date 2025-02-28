class RemovePlanIdFromFeatures < ActiveRecord::Migration[7.2]
  def change
    remove_column :features, :plan_id, :integer
  end
end
