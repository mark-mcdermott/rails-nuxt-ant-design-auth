class RemovePurchaseTypeIdFromBudget < ActiveRecord::Migration[7.0]
  def change
    remove_column :budgets, :purchase_type_id
  end
end
