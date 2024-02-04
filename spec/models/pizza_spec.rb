require 'rails_helper'

RSpec.describe Pizza, type: :model do
  it { should have_many(:order_items) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
