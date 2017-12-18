class HomeController < ShopifyApp::AuthenticatedController
  include HomeHelper

  def index
    @shop = Shop.find_by(shopify_domain: shop_session.url)
    @customers = @shop.customers
  end
end
