# frozen_string_literal: true

require 'rails_helper'

describe OrderItemBlueprint do
  let(:pizza) { create(:pizza) }
  let(:order_item) { create(:order_item, pizza: pizza) }
  let(:response) { OrderItemBlueprint.render(order_item) }

  describe 'schema' do
    it 'match with specification' do
      schema_path = "#{Dir.pwd}/spec/support/api/schemas/order_item.json"
      JSON::Validator.validate!(schema_path, response)
    end
  end
end
