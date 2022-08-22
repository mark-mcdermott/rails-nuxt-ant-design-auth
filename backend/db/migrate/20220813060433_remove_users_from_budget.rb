class RemoveUsersFromBudget < ActiveRecord::Migration[7.0]
  def change
    remove_column :budgets, :user_id
  end
end
