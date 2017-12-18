Rails.application.routes.draw do
  root :to => 'home#index'

  scope module: 'shopify_app' do
    resource :webhooks do
      post :orders_create
      post :orders_update
      post :customers_create
      post :customers_update
    end
  end

  mount ShopifyApp::Engine, at: '/'
end
