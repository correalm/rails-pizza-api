class OrderBlueprint < Blueprinter::Base
  fields :id, :created_at, :updated_at

  association :order_items, name: :items, blueprint: OrderItemBlueprint
end
