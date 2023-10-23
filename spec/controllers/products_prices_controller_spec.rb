require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /products_prices' do
    let(:mugs) do
      FactoryBot.create(:category, name: 'MUG')
    end

    let(:tshirts) do
      FactoryBot.create(:category, name: 'TSHIRT')
    end

    let!(:mug_product) do
      FactoryBot.create(
        :product,
        category: mugs,
        name: 'Reedsy Mug',
        price_in_cents: 600
      )
    end

    let!(:tshirt_product) do
      FactoryBot.create(
        :product,
        category: tshirts,
        name: 'Reedsy T-shirt',
        price_in_cents: 1500
      )
    end

    let(:items) do
      ["#{mug_product.id}, 1", "#{tshirt_product.id}, 1"]
    end

    subject do
      get "/products_prices", params: { items: items }
     end

    it 'returns status code 200' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct total price' do
      subject

      expect(JSON.parse(response.body)['total_price']).to equal(21.0)
    end

    context 'when there are discounts' do
      let!(:tshirt_discount) do
        FactoryBot.create(
          :discount,
          :enabled,
          volume: 30,
          category: tshirts,
          from_num_of_items: 3,
        )
      end

      let!(:discount_2) do
        FactoryBot.create(
          :discount,
          :enabled,
          volume: 2,
          category: mugs,
          from_num_of_items: 10,
        )
      end

      let(:items) do
        ["#{mug_product.id}, 10", "#{tshirt_product.id}, 1"]
      end

      subject do
        get "/products_prices", params: { items: items }
       end


      it 'returns status code 200' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'returns the correct total price' do
        subject

        expect(JSON.parse(response.body)['total_price']).to equal(73.80)
      end
    end
  end
end
