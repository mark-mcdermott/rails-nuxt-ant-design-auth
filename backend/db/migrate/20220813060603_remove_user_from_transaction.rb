class RemoveUserFromTransaction < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :user_id
  end
end
