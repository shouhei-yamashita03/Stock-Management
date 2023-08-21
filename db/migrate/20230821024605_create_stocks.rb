class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :category_name
      t.string :stock_name
      t.text :stock_description
      t.integer :quantity

      t.timestamps
    end
  end
end
