class AddDisplayNumberToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :display_number, :integer
  end
end
