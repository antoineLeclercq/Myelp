class User < ApplicationRecord
  has_many :reviews

  validates :full_name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password validations: false

  def location
    "#{city}, #{state}"
  end

  def reviews_count
    reviews.count
  end
end
