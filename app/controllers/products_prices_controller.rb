class ProductsPricesController < ApplicationController

  # GET /products_prices
  def index
    params

    items = params[:items]

    if items.blank?
      render json: { error: 'no specified items', status: :not_found }

      return
    end

    total_price = 0

    # product_id => quantity
    items_hash = items.map do |item|
      item.split(',').map(&:to_i)
    end.to_h

    products = Product.
      where(id: items_hash.keys).
      index_by(&:id)

    items_hash.each do |product_id, quantity|
      if product = products[product_id]
        total_price += product.get_price_with_discount(quantity)
      else
        render json: { error: "Product with id: '#{product_id}' not found in the store" }, status: :not_found
        return
      end
    end

    render json: { total_price: total_price.to_f / 100 }
  end
end
