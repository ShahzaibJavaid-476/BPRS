class RemoveDefaultAndTrueFromSubscriptions < ActiveRecord::Migration[7.2]
  def change
    remove_column :subscriptions, :default, :string
    remove_column :subscriptions, :true, :string
  end
end
