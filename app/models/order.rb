class Order < ApplicationRecord
  validates :status, inclusion: { in: ['pending', 'processing', 'fulfilled', 'delivered', 'canceled'] }
  validates :order_variant, length: { minimum: 1 }
  belongs_to :customer
  has_many :order_variant

  validates_presence_of :customer, :subtotal

  def as_json(options=nil)
    attributes.merge(:order_variant => order_variant)
  end
end
