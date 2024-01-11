require 'rails_helper'

RSpec.describe 'Api::Pizzas', type: :request do
  describe 'GET /api/pizzas' do
    it 'responds with 200' do
      create_list(:pizza, 2)

      get api_pizzas_path

      expect(response).to have_http_status :ok
    end

    it 'responds with resources' do
      create_list(:pizza, 2)

      get api_pizzas_path

      parsed_body = JSON.parse(response.body)

      expect(parsed_body.first).to match_json_schema('pizzas')
      expect(parsed_body.last).to match_json_schema('pizzas')
    end
  end

  describe 'GET /api/:id' do
    context 'when resource is founded' do
      it 'responds with 200' do
        create_list(:pizza, 2)

        get api_pizza_path(Pizza.first.id)

        expect(response).to have_http_status :ok
      end

      it 'responds with the resource' do
        create_list(:pizza, 2)

        get api_pizza_path(Pizza.first.id)

        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to match_json_schema('pizzas')
        expect(parsed_body['id']).to be(Pizza.first.id)
      end
    end

    context 'when resource is not founded' do
      it 'responds with 404' do
        get api_pizza_path(1), as: :json

        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'POST /api/pizzas' do
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

  describe 'PUT /api/pizzas/:id' do
    context 'when record is founded' do
      context 'given valid params' do
        it 'responds with 200' do
          create(:pizza)

          params = { pizza: { name: 'foo-bar' } }

          put api_pizza_path(Pizza.first.id), params: params

          expect(response).to have_http_status :ok
        end

        it 'update the record' do
          create(:pizza)

          params = { pizza: { name: 'foo-bar' } }

          put api_pizza_path(Pizza.first.id), params: params

          parsed_body = JSON.parse(response.body)

          expect(parsed_body).to match_json_schema('pizzas')
          expect(parsed_body['name']).to eq(params[:pizza][:name])
        end
      end

      context 'given invalid params' do
        it 'responds with 200' do
          create(:pizza)

          params = { pizza: { price: '33.43' } }
          put api_pizza_path(Pizza.first.id), params: params.to_json, headers: { 'Content-Type': 'application/json' }

          expect(response).to have_http_status :ok
        end

        it 'not changes the record' do
          create(:pizza)

          params = { pizza: { price: '33.43' } }
          put api_pizza_path(Pizza.first.id), params: params.to_json, headers: { 'Content-Type': 'application/json' }

          parsed_body = JSON.parse(response.body)

          expect(parsed_body['price']).to eq(Pizza.first.price)
        end
      end
    end

    context 'when record is not founded' do
      it 'responds with 404' do
        put api_pizza_path(2)

        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'DELETE api/pizza/:id' do
    context 'when resource is founded' do
      let(:pizza) { create(:pizza) }

      it 'returns 201' do
        delete api_pizza_path(pizza.id)

        expect(response).to have_http_status :no_content
      end

      it 'delets the record' do
        delete api_pizza_path(pizza.id)

        expect(Pizza.count).to eq(0)
      end
    end

    context 'when resource is not founded' do
      it 'return 404' do
        delete api_pizza_path(1)

        expect(response).to have_http_status :not_found
      end
    end
  end
end
