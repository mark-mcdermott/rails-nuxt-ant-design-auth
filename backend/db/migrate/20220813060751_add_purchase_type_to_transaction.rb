class AddPurchaseTypeToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :purchase_type, null: false, foreign_key: true
  end
end
