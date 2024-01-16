# frozen_string_literal: true

require 'rails_helper'

describe OrderItemBlueprint do
  let(:pizza) { create(:pizza) }
  let(:order_item) { create(:order_item, pizza: pizza) }
  let(:response) { OrderItemBlueprint.render(order_item) }

  describe 'schema' do
    it { expect(response).to match_schema('order_item') }
  end
end
