FactoryBot.define do
  factory :order_item do
    association :pizza
    association :order
  end
end
