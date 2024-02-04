require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:pizza) }
  it { should belong_to(:order) }

  it { should validate_numericality_of(:quantity) }
end
