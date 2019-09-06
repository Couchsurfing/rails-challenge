class Variant < ApplicationRecord
  belongs_to :product
  has_many :order, through: :order_variant

  def as_json(_options = nil)
    attributes.merge(product: product)
  end
end
