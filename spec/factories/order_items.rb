FactoryBot.define do
  factory :order_item do
    quantity { rand(1..9) }
    pizza
    order
  end
end
