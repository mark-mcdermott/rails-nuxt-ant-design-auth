class RemoveUserIdFromAccount < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :user_id
  end
end
