class Product < ApplicationRecord
  validates :stock, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true
  validates :description, presence: true
  validates :kind, presence: true
  has_many :cart_items
  has_many :users, through: :comments
  has_many :comments
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :product_purchases
  has_many :stock_updates
  # product.name
  def self.search(search)
    return Product.all unless search
    Product.where(['name LIKE ?', "%#{search}%"])
  end
  # product.description
  def self.description(search)
    return Product.all unless search
    Product.where(['description LIKE ?', "%#{search}%"])
  end
  mount_uploader :image, ImagesUploader

  scope :price_high, -> { order(price: :desc) }
  scope :price_low, -> { order(price: :asc) }
  scope :latest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }

  scope :price_zone, -> from, to {
    return Product.all if from.blank? && to.blank?
    return Product.where('price <= ?', to) if from.blank?
    return Product.where('price >= ?', from) if to.blank?
    return Product.all if from > to

    Product.where(price: from..to)
  }

  scope :select_kind, -> kind {
    return Product.all unless kind
    return Product.all if kind.blank?
    Product.where(kind: "#{kind}")
  }

  scope :who_desiner, -> designer {
    return Product.all unless designer
    return Product.all if designer.blank?
    Product.where(designer: "#{designer}")
  }

  scope :select_size, -> size {
    return Product.all unless size
    return Product.all if size.blank?
    Product.where(size: "#{size}")
  }

  scope :is_sale?, -> sale {
    return Product.all unless sale
    return Product.all if sale.blank?
    Product.where(sale: sale)
  }

  scope :stock_valid?, -> valid {
    return Product.all unless valid
    return Product.all if valid.blank?
    return Product.where(stock: 1..100) if valid == "true"
    Product.all
  }

  scope :stock_present, -> { where(stock: 1..Float::INFINITY) }

  scope :stock_blank, -> { where(stock: 0) }

  def self.csv_attributes
    products = self.all
    products.each do |p|
      if p.product_purchases.present?
        ["name","num"]
      else
        ["name","0"]
      end
    end
  end

  def self.ja_csv_attributes
    ["商品名","商品販売個数"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << ja_csv_attributes
      all.each do |product|
        csv << csv_attributes.map{|attr| product.send(attr)}
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      product = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      product.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      product.save
    end
  end

  def self.updatable_attributes
    ["id", "name", "description","price","kind","image","stock","designer","sale", "size"]
  end

  def self.csv_attributes
    ["id", "name", "description","price","kind","image","stock","designer","sale", "size"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |product|
        csv << csv_attributes.map{|attr| product.send(attr)}
      end
    end
  end
end
