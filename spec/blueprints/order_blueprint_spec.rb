# frozen_string_literal: true

require 'rails_helper'

describe OrderBlueprint do
  let(:order) { create(:order_with_items) }
  let(:response) { OrderBlueprint.render(order) }

  describe 'schema' do
    it { expect(response).to match_schema('order') }
  end
end
