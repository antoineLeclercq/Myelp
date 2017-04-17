class User < ApplicationRecord
  validates :full_name, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password validations: false
end
