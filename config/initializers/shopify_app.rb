ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "54ea2b6ed623bd004527cb7fde5f3303"
  config.secret = "53aee7eeeb78394a8d9ffe1fcdc9176b"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
  config.webhooks = [
    { topic: 'orders/create', address: 'https://3cd30634.ngrok.io/webhooks/orders_create' },
    { topic: 'orders/update', address: 'https://3cd30634.ngrok.io/webhooks/orders_update' },
    { topic: 'customers/create', address: 'https://3cd30634.ngrok.io/webhooks/customers_create' },
    { topic: 'customers/update', address: 'https://3cd30634.ngrok.io/webhooks/customers_update' }
  ]
end
