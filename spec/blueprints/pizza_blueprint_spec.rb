# frozen_string_literal: true

require 'rails_helper'

describe PizzaBlueprint do
  let(:pizza) { create(:pizza) }
  let(:response) { PizzaBlueprint.render(pizza) }

  describe 'schema' do
    it 'match with specification' do
      schema_path = "#{Dir.pwd}/spec/support/api/schemas/pizza.json"
      JSON::Validator.validate!(schema_path, response)
    end
  end
end
