class Variant < ApplicationRecord
  belongs_to :product

  def as_json(options=nil)
    attributes.merge(:product => product)
  end
end
