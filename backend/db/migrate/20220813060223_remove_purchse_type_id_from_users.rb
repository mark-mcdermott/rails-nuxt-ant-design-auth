class RemovePurchseTypeIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :purchase_type_id
  end
end
