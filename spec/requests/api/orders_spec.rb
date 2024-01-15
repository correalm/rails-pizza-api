require 'rails_helper'

describe 'Api::Orders', type: :request do
  describe 'GET /api/orders' do
    let!(:orders) { create_list(:order_with_items, 2) }

    it 'responds with 200' do
      get api_orders_path

      expect(response).to have_http_status :ok
    end

    it 'responds with resources' do
      get api_orders_path

      parsed_body = JSON.parse(response.body)
      byebug

      expect(parsed_body.first).to match_json_schema('orders')
      expect(parsed_body.last).to match_json_schema('orders')
    end
  end

 # describe 'GET /api/orders/:id' do
 #   context 'when resource is founded' do
 #     it 'responds with 200' do
 #       create_list(:order, 2)

 #       get api_order_path(Order.first.id)

 #       expect(response).to have_http_status :ok
 #     end

 #     it 'responds with the resource' do
 #       create_list(:order, 2)

 #       get api_order_path(Order.first.id)

 #       parsed_body = JSON.parse(response.body)

 #       expect(parsed_body).to match_json_schema('order')
 #       expect(parsed_body['id']).to be(Order.first.id)
 #     end
 #   end

 #   context 'when resource is not founded' do
 #     it 'responds with 404' do
 #       get api_order_path(1), as: :json

 #       expect(response).to have_http_status :not_found
 #     end
 #   end
 # end

 # describe 'POST /api/pizzas' do
 #   context 'given invalid params' do
 #     it 'respond with 422 status code' do
 #     end
 #   end

 #   context 'given valid params' do
 #     it 'returns 201 status code' do
 #     end

 #     it 'returns the created pizza' do
 #     end
 #   end
 # end

 # describe 'PUT /api/pizzas/:id' do
 #   context 'when record is founded' do
 #     context 'given valid params' do
 #       it 'responds with 200' do
 #       end

 #       it 'update the record' do
 #       end
 #     end

 #     context 'given invalid params' do
 #       it 'responds with 200' do
 #       end

 #       it 'not changes the record' do
 #       end
 #     end
 #   end

 #   context 'when record is not founded' do
 #     it 'responds with 404' do
 #     end
 #   end
 # end

 # describe 'DELETE api/pizza/:id' do
 #   context 'when resource is founded' do
 #     it 'returns 201' do
 #     end

 #     it 'delets the record' do
 #     end
 #   end

 #   context 'when resource is not founded' do
 #     it 'return 404' do
 #     end
 #   end
 # end
end
