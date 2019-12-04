class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true
  validates :description, presence: true
  validates :kind, presence: true
  has_many :cart_items
  has_many :users, through: :comments
  has_many :comments
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
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
    if from.blank? && to.blank?
    elsif from.blank?
      where('price <= ?', to)
    elsif to.blank?
      where('price >= ?', from)
    else
      where(price: from..to)
    end
  }
end
