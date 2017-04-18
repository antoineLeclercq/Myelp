class Business < ApplicationRecord
  has_many :reviews

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: { only_integer: true }
  validates :phone, presence: true, numericality: { only_integer: true }
end
