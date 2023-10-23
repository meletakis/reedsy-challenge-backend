require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /index' do
    let!(:prodcuts) { FactoryBot.create_list(:product, 5) }

    subject { get '/products' }

    it 'returns all products' do
      subject

      expect(JSON.parse(response.body).size).to eq(5)
    end

    it 'returns status code 200' do
      subject

      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT /update' do
    let!(:product) { FactoryBot.create(:product, price_in_cents: 1000) }

    describe 'with valid params' do
      let(:new_price) { 1100 }

      subject do
         put "/products/#{product.id}", params:
          { product: { price_in_cents: new_price } }
       end

       it 'returns the product with the new price' do
        subject

         expect(JSON.parse(response.body)['price_in_cents']).to eq(new_price)
       end

       it 'returns a success status' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'changes the price of the product' do
        expect {
          subject
        }.to change {
          product.reload.price_in_cents
        }.from(1000).to(new_price)
      end
    end
  end
end
