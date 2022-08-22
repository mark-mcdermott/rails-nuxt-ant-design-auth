class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.datetime :date
      t.string :amount
      t.string :balance
      t.integer :purchase_type_id
      t.string :description

      t.timestamps
    end
  end
end
