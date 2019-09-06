require 'rails_helper'

RSpec.describe OrderVariant, type: :model do
  it { should belong_to(:order) }
  it { should have_one(:variant) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:item_cost) }
end
