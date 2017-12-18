class OrdersCreateJob < ActiveJob::Base
  def perform(shop_domain:, orders_param:)
    shop = Shop.find_by(shopify_domain: shop_domain)

    shop.with_shopify_session do
      customer = shop.customers.find_by(shopify_customer_id: orders_param[:customer][:id])
      customer ||= shop.customers.build(orders_param[:customer].slice(:email, :first_name, :last_name).merge(shopify_customer_id: orders_param[:customer][:id]))

      customer.tags << 'new' if orders_param[:customer][:orders_count].to_i == 1

      if orders_param[:total_price].to_f >= 1000
        customer.tags << 'vip' if customer.tags.exclude?('vip')
      end

      if orders_param[:customer][:orders_count].to_i > 1
        debugger
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
