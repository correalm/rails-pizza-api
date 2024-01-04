module Api
  class OrderItemsController < ApiController
    before_action :set_order_item, only: [:show, :update, :destroy]

    def index
      @order_items = OrderItem.all

      render json: @order_items
    end

    def show
      render json: @order_item
    end

    def create
      @order_item = OrderItem.new(order_item_params)

      if @order_item.save
        render json: @order_item, status: :created, location: @order_item
      else
        render json: @order_item.errors, status: :unprocessable_entity
      end
    end

    def update
      if @order_item.update(order_item_params)
        render json: @order_item
      else
        render json: @order_item.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @order_item.destroy
    end

    private

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:pizza_id, :quantity)
    end
  end
end
