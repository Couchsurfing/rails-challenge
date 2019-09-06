class Order < ApplicationRecord
  validates :status, inclusion: { in: %w[pending processing fulfilled delivered canceled] }
  validates :order_variant, length: { minimum: 1 }
  belongs_to :customer
  has_many :order_variant

  validates_presence_of :customer, :subtotal

  def as_json(_options = nil)
    attributes.merge(order_variant: order_variant, customer: customer)
  end
end
