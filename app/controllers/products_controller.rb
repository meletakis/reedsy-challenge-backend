class ProductsController < ApplicationController
  before_action :set_product, only: %i[update]

  # GET /products
  def index
    # TODO: Add pagination
    @products = Product.all.preload(:category).map do |product|
      {
        id: product.id,
        code: product.category.name,
        name: product.name,
        price: (product.price_in_cents / 100).to_f
      }
    end

    render json: @products
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:price_in_cents)
  end
end
