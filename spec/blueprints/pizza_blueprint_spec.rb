# frozen_string_literal: true

require 'rails_helper'

describe PizzaBlueprint do
  let(:pizza) { create(:pizza) }
  let(:response) { PizzaBlueprint.render(pizza) }

  describe 'schema' do
    it { expect(response).to match_schema('pizza') }
  end
end
