Rails.application.routes.draw do
  namespace :api do
    resources :orders
    resources :order_items
    resources :pizzas
  end
end
