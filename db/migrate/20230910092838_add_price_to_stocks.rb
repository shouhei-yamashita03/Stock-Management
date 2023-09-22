class AddPriceToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :price, :integer
  end
end
