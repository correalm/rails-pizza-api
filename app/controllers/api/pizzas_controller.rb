module Api
  class PizzasController < ApiController
    before_action :set_pizza, only: [:show, :update, :destroy]

    def index
      @pizzas = Pizza.all

      render json: PizzaBlueprint.render(@pizzas)
    end

    def show
      render json: PizzaBlueprint.render(@pizza)
    end

    def create
      @pizza = Pizza.new(pizza_params)

      if @pizza.save
        render json: PizzaBlueprint.render(@pizza), status: :created
      else
        render json: @pizza.errors, status: :unprocessable_entity
      end
    end

    def update
      if @pizza.update(pizza_params)
        render json: @pizza
      else
        render json: @pizza.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @pizza.destroy
    end

    private

    def set_pizza
      @pizza = Pizza.find(params[:id])
    end

    def pizza_params
      params.require(:pizza).permit(:name, :price)
    end
  end
end
