class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    redirect_to action: :demo
    # get 5 products
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

    # get latest 5 orders
#    @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
  end

  def metafields
    params[:product_ids].each do |product_id|
      @product = ShopifyAPI::Product.find(product_id)
      meta_field = ShopifyAPI::Metafield.new(namespace: 'testapp', key: 'tax_class', value_type: "string", value: params["class_#{product_id}".to_sym])
      @product.add_metafield(meta_field)
    end
    redirect_to :demo
  end

  def demo
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
  end
  
end
