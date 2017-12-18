class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  has_many :customers
end
