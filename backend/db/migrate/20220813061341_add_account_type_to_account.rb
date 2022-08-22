class AddAccountTypeToAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :accounts, :account_type, null: false, foreign_key: true
  end
end
