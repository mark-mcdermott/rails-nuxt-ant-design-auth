class AddPurchaseTypeToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :purchase_type, null: false, foreign_key: true
  end
end
