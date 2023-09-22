class Stock < ApplicationRecord
    belongs_to :user

    validates :category_name, presence: true, length: { maximum: 50 }
    validates :stock_name, presence: true, length: { maximum: 50 }
    validates :stock_description, length: { maximum: 100 }
    validates :quantity, presence: true
    validates :price, presence: true
    validates :display_number, presence: true, length: { maximum: 10 }

    require 'csv'

    def self.csv_import(file, user)
        stocks = []
        ActiveRecord::Base.transaction do
        CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS', col_sep: ',') do |row|
            stock = Stock.new
            stock = find_by(id: row['id']) || new
            row_hash = row.to_hash.slice(*CSV_HEADER.keys)
            stock.attributes = row_hash.transform_keys(&CSV_HEADER.method(:[]))
            stock.user_id = user.id
            stocks << stock
            stock.save!
        end
        end
    end

    CSV_HEADER = {
        '陳列番号' => 'display_number',
        'カテゴリー名' => 'category_name',
        '在庫名' => 'stock_name',
        '在庫の説明' => 'stock_description',
        '価格' => 'price',
        '数量' => 'quantity'
    }.freeze
end
