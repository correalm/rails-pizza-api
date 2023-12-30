class AddOrderRefToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_items, :order, index: true, null: false, foreign_key: true
  end
end
