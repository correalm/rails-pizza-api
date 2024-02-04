class OrderItem < ApplicationRecord
  belongs_to :pizza
  belongs_to :order

  validates :quantity, numericality: { only_integer: true }
end
