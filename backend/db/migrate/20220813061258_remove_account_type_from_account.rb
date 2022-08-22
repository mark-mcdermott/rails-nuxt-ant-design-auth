class RemoveAccountTypeFromAccount < ActiveRecord::Migration[7.0]
  def change
    remove_column :accounts, :account_type_id
  end
end
