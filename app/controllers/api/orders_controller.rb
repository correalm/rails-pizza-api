module Api
  class OrdersController < ApiController
    before_action :set_order, only: [:show, :update, :destroy]

    def index
      @orders = Order.all

      render json: OrderBlueprint.render(@orders)
    end

    def show
      render json: OrderBlueprint.render(@order)
    end

    def create
      @order = Order.new(order_params)

      if @order.save
        render json: OrderBlueprint.render(@order), status: :created
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end

    def update
      if @order.update(order_params)
        render json: OrderBlueprint.render(@order)
      else
        render json: @order.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @order.destroy
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.fetch(:order, {})
    end
  end
end
