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

      expect(parsed_body.first).to match_schema('order')
      expect(parsed_body.last).to match_schema('order')
    end
  end

  describe 'GET /api/orders/:id' do
    context 'when resource is founded' do
      let(:orders) { create_list(:order, 2) }

      it 'responds with 200' do
        get api_order_path(orders.first.id)

        expect(response).to have_http_status :ok
      end

      it 'responds with the resource' do
        get api_order_path(orders.second.id)

        parsed_body = JSON.parse(response.body)

        expect(parsed_body).to match_schema('order')
        expect(parsed_body['id']).to be(orders.second.id)
      end
    end

    context 'when resource is not founded' do
      it 'responds with 404' do
        get api_order_path(1), as: :json

        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'POST /api/orders' do
    context 'given valid params' do
      let(:pizza) { create(:pizza) }
      let(:order_items_attributes) { [{ quantity: 1, pizza_id: pizza.id }] }

      it 'returns 201 status code' do
        post api_orders_path, params: { order: { order_items_attributes: order_items_attributes } }

        expect(response).to have_http_status :created
      end

      it 'returns the created order' do
        post api_orders_path, params: { order: { order_items_attributes: order_items_attributes } }

        expect(response.body).to match_schema('order')
      end

      it 'persist the passed order items' do
        post api_orders_path, params: { order: { order_items_attributes: order_items_attributes } }

        parsed_response = JSON.parse(response.body)

        expect(OrderItem.count).to eq(1)
        expect(OrderItem.first.order.id).to eq(parsed_response['id'])
      end
    end
  end

  describe 'PUT api/order/:id' do
    context 'when record is founded' do
      let(:orders) { create_list(:order, 2) }

      context 'given valid params' do
        let(:order_items_attributes) { [{ quantity: 1, pizza_id: create(:pizza).id }] }

        it 'responds with 200' do
          put api_order_path(orders.first.id), params: {
            order: { order_items_attributes: order_items_attributes }
          }

          expect(response).to have_http_status :ok
        end

        it 'update the record' do
          expect(orders.first.order_items.count).to eq(0)

          put api_order_path(orders.first.id), params: {
            order: { order_items_attributes: order_items_attributes }
          }

          expect(orders.first.order_items.count).to eq(1)
          expect(orders.first.order_items.first.quantity).to eq(order_items_attributes[0][:quantity])
        end
      end

      context 'given invalid params' do
        let(:order) { create(:order) }
        let(:invalid_attr) { [{ quantity: '1', pizza_id: nil }] }

        it 'responds with 422' do
          put api_order_path(order.id), params: { order: { order_items_attributes: invalid_attr } }

          expect(response).to have_http_status :unprocessable_entity
        end

        it 'not changes the record' do
          put api_order_path(order.id), params: { order: { order_items_attributes: invalid_attr } }

          expect(order.order_items.count).to eq(0)
        end
      end
    end

    context 'when record is not founded' do
      it 'responds with 404' do
        put api_order_path('foo-bar')

        expect(response).to have_http_status :not_found
      end
    end
  end

  describe 'DELETE api/order/:id' do
    context 'when resource is founded' do
      let!(:order) { create(:order) }
 
      it 'returns 204' do
        delete api_order_path(order.id)
 
        expect(response).to have_http_status :no_content
      end
 
      it 'delets the record' do
        expect(Order.count).to eq(1)
 
        delete api_order_path(order.id)
 
        expect(Order.count).to eq(0)
      end
    end
 
    context 'when resource is not founded' do
      it 'return 404' do
        delete api_order_path('foo-bar')
        expect(response).to have_http_status :not_found
      end
    end
  end
end
