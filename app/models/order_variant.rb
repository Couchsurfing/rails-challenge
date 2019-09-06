class OrderVariant < ApplicationRecord
  belongs_to :order
  has_one :variant

  validates_presence_of :quantity, :item_cost
end
