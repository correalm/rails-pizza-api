require 'rails_helper'

RSpec.describe 'Api::Pizzas', type: :request do
  describe 'GET /index' do
    it 'returns pizzas' do
      create_list(:pizza, 2)

      get api_pizzas_path

      body = JSON.parse(response.body)

      expect(response).to have_http_status :ok
      expect(body.first).to match_json_schema('pizzas')
      expect(body.last).to match_json_schema('pizzas')
    end
  end

  describe 'POST /index' do
    context 'given invalid params' do
      it 'respond with 422 status code' do
        params = { pizza: { price: 12.23 } }

        post api_pizzas_path, params: params

        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'given valid params' do
      it 'returns 201 status code' do
        params = { pizza: { price: 12.24, name: 'foo-bar' } }

        post api_pizzas_path, params: params

        expect(response).to have_http_status :created
      end

      it 'returns the created pizza' do
        params = { pizza: { price: 12.24, name: 'foo-bar' } }

        post api_pizzas_path, params: params

        expect(response.body).to match_json_schema('pizzas')
      end
    end
  end
end
