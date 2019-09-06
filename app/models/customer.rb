class Customer < ApplicationRecord
  has_many :order
  validates :email, case_sensitive: false
end
