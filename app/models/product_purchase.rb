class ProductPurchase < ApplicationRecord
  belongs_to :user
  belongs_to :product, optional: true

  validate :date_is_two_days_late_and_within_one_month

  def date_is_two_days_late_and_within_one_month
    errors.add(:delivery_date, "は今日から2日後かつ１ヶ月以内を選択してください。") if delivery_date.nil? || delivery_date < Time.current.since(2.days) || delivery_date > Time.current.next_month
  end

  enum delivery_zone: {
    午前中: 1, "14時から16時": 2, "16時から18時": 3, "18時から20時": 4, "19時から21時": 5
  }
end
