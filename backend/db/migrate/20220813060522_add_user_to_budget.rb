class AddUserToBudget < ActiveRecord::Migration[7.0]
  def change
    add_reference :budgets, :user, null: false, foreign_key: true
  end
end
