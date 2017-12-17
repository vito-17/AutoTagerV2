module ShopifyApp
  class WebhooksController < ActionController::Base
    include ShopifyApp::WebhookVerification

    class ShopifyApp::MissingWebhookJobError < StandardError; end

    def orders_create
      params.permit!
      job_args = {shop_domain: shop_domain, webhook: webhook_params.to_h}
      OrdersCreateJob.perform_later(job_args)
      head :no_content
    end

    def orders_update
      params.permit!
      job_args = {shop_domain: shop_domain, webhook: webhook_params.to_h}
      OrdersUpdateJob.perform_later(job_args)
      head :no_content
    end

    def customers_create
      params.permit!
      job_args = {shop_domain: shop_domain, webhook: webhook_params.to_h}
      CustomersCreateJob.perform_later(job_args)
      head :no_content
    end

    def customers_update
      params.permit!
      job_args = {shop_domain: shop_domain, webhook: webhook_params.to_h}
      CustomersUpdateJob.perform_later(job_args)
      head :no_content
    end

    private

    def webhook_params
      params.except(:controller, :action, :type)
    end
  end
end
