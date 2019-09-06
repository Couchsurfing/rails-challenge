class OrderVariant < ApplicationRecord
  belongs_to :order
  belongs_to :variant

  validates_presence_of :quantity, :item_cost
end
