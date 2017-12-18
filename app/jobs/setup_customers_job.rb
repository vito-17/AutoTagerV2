class SetupCustomersJob < ActiveJob::Base
  def perform(shop_domain:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    shop.with_shopify_session do
      orders = ShopifyAPI::Order.find(:all)

      orders.each do |o|
        next unless o.try(:customer)

        customer = Customer.find_or_initialize_by(
          shop: shop,
          shopify_customer_id: o.customer.id,
          email: o.customer.email,
          first_name: o.customer.first_name,
          last_name: o.customer.last_name
        )

        customer.tags << 'new' if o.customer.orders_count == 1

        if o.total_price.to_f >= 1000
          customer.tags << 'vip' if customer.tags.exclude?('vip')
        end

        if o.customer.orders_count > 1
          if customer.tags.include?('new')
            customer.tags.delete('new')
          end

          if customer.tags.exclude?('repeat')
            customer.tags << 'repeat'
          end
        end

        customer.save!
      end
    end
  end
end
