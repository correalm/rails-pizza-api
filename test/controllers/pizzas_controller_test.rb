require "test_helper"

class PizzasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pizza = pizzas(:one)
  end

  test "should get index" do
    get pizzas_url, as: :json
    assert_response :success
  end

  test "should create pizza" do
    assert_difference('Pizza.count') do
      post pizzas_url, params: { pizza: { name: @pizza.name, price: @pizza.price } }, as: :json
    end

    assert_response 201
  end

  test "should show pizza" do
    get pizza_url(@pizza), as: :json
    assert_response :success
  end

  test "should update pizza" do
    patch pizza_url(@pizza), params: { pizza: { name: @pizza.name, price: @pizza.price } }, as: :json
    assert_response 200
  end

  test "should destroy pizza" do
    assert_difference('Pizza.count', -1) do
      delete pizza_url(@pizza), as: :json
    end

    assert_response 204
  end
end
