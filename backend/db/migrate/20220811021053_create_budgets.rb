class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.integer :purchase_type_id
      t.integer :value
      t.string :subtitle
      t.string :notes
      t.integer :user_id

      t.timestamps
    end
  end
end
