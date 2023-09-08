class Stock < ApplicationRecord
    belongs_to :user

    validates :category_name, presence: true, length: { maximum: 50 }
    validates :stock_name, presence: true, length: { maximum: 50 }
    validates :stock_description, length: { maximum: 100 }
    validates :quantity, presence: true

    require 'csv'

    def self.csv_import(file, user)
    stocks = []
    # CSV.foreachのencodingオプションをShift_JISからUTF-8に変更します
    CSV.foreach(file.path, headers: true, encoding: 'UTF-8', col_sep: ',') do |row|
        stock = Stock.find_by(id: row['id']) || Stock.new
        row_hash = row.to_hash.slice(*CSV_HEADER.keys)
        stock.attributes = row_hash.transform_keys(&CSV_HEADER.method(:[]))
        stock['user_id'] = user.id
        stocks << stock
    end
    Stock.import stocks
    end

    CSV_HEADER = {
    'カテゴリー名' => 'category_name',
    '在庫名' => 'stock_name',
    '数量' => 'quantity'
    }.freeze
end
