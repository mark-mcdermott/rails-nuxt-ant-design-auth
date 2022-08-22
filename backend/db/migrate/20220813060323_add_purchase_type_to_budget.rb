class AddPurchaseTypeToBudget < ActiveRecord::Migration[7.0]
  def change
    add_reference :budgets, :purchase_type, null: false, foreign_key: true
  end
end
