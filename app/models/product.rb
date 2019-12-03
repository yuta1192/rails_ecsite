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
  def self.search(search)
    return Product.all unless search
    Product.where(['name LIKE ?', "%#{search}%"])
  end
  mount_uploader :image, ImagesUploader

  scope :price_high, -> { order(price: :desc) }
  scope :price_low, -> { order(price: :asc) }
  scope :latest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }
end
