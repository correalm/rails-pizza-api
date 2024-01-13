class OrderItemBlueprint < Blueprinter::Base
  fields :id, :quantity, :created_at, :updated_at

  association :pizza, blueprint: PizzaBlueprint
end
