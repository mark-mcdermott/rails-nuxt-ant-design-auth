class RemoveUserFromAsset < ActiveRecord::Migration[7.0]
  def change
    remove_column :assets, :user_id
  end
end
