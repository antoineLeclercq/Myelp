class Business < ApplicationRecord
  has_many :reviews, -> { order(created_at: :desc) }

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: { only_integer: true }
  validates :phone, presence: true, numericality: { only_integer: true }

  def average_rating
    (reviews.sum(:rating) / reviews.count.to_f).round(1)
  end
end
