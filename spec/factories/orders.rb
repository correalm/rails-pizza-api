FactoryBot.define do
  factory :order do
    factory :order_with_items do
      transient do
        items_count { 5 }
        pizza { create(:pizza) }
      end

      after(:create) do |order, context|
        create_list(:order_item,
                    context.items_count,
                    order: order,
                    pizza: context.pizza,
                    quantity: rand(4))
      end
    end
  end
end
