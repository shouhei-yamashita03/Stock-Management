class AddUserIdToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :user_id, :integer
  end
end
