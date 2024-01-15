require 'rails_helper'

describe OrderBlueprint do
  let(:order) { create(:order_with_items) }
  let(:response) { OrderBlueprint.render(order) }

  describe 'schema' do
    it 'match with specification' do
      schema_path = "#{Dir.pwd}/spec/support/api/schemas/order.json"
      JSON::Validator.validate!(schema_path, response, strict: true)
    end
  end
end
