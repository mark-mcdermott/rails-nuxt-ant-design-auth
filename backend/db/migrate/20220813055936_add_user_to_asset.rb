class AddUserToAsset < ActiveRecord::Migration[7.0]
  def change
    add_reference :assets, :user, null: false, foreign_key: true
  end
end
