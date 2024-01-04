require 'rails_helper'

RSpec.describe 'Pizzas', type: :request do
  describe 'GET /index' do
    it 'returns pizzas' do
      create_list(:pizza, 2)

      get pizzas_path

      expect(response).to have_http_status :ok
      expect(response).to match_json_schema('pizzas')
    end
  end
end
