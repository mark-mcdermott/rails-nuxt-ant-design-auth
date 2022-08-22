class Remove < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :purchase_type_id
  end
end
