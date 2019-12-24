class ProductPurchase < ApplicationRecord
  def self.csv_attributes
    ["id", "user_id", "product_id", "num", "order_id", "shipping_zip_code", "shipping_prefectures", "shipping_address", "delivery_date", "delivery_zone"]
  end

  def self.ja_csv_attributes
    ["ID", "ユーザID", "商品ID", "個数", "注文番号", "宛先郵便番号", "宛先都道府県", "宛先住所", "配送日", "配送時間帯"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << ja_csv_attributes
      all.each do |product_purchase|
        csv << csv_attributes.map{|attr| product_purchase.send(attr)}
      end
    end
  end

  belongs_to :user
  belongs_to :product, optional: true
  has_many :product_purchase_shipments
  has_many :shipment, through: :product_purchase_shipments

  validate :date_is_two_days_late_and_within_one_month

  def date_is_two_days_late_and_within_one_month
    errors.add(:delivery_date, "は今日から2日後かつ１ヶ月以内を選択してください。") if delivery_date.nil? || delivery_date < Time.current.since(2.days) || delivery_date > Time.current.next_month
  end

  enum delivery_zone: {
    午前中: 1, "14時から16時": 2, "16時から18時": 3, "18時から20時": 4, "19時から21時": 5
  }

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product_purchase = find_by(order_id: row["order_id"]) || new
      # CSVからデータを取得し、設定する
      product_purchase.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      product_purchase.save
    end
  end

  def self.updatable_attributes
    ["id", "user_id", "product_id", "num", "order_id", "shipping_zip_code", "shipping_prefectures", "shipping_address", "delivery_date", "delivery_zone", "finish_flag"]
  end

  def self.search(order_id)
    return ProductPurchase.all.uniq(&:order_id) unless order_id
    ProductPurchase.where(['order_id LIKE ?', "%#{order_id}%"])
  end
end
