class AddImageToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :image, :string
  end
end
