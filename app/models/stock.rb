class Stock < ApplicationRecord
    validates :category_name, presence: true, length: { maximum: 50 }
    validates :stock_name, presence: true, length: { maximum: 50 }
    validates :stock_description, length: { maximum: 100 }
    validates :quantity, presence: true
end
