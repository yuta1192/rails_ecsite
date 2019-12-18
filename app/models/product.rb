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
end
