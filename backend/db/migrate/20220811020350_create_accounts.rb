class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :account_type_id
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
