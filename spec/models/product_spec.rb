require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    let(:category) { FactoryBot.create(:category) }

    context 'when product has no name' do
      let(:product) { Product.new(name: '', category: category) }

      it 'is not valid' do
        expect(product).to be_invalid
      end

      it 'has error on name' do
        product.valid?

        expect(product.errors[:name].first).to match(/can\'t be blank/)
      end
    end

    context 'when product has no category' do
      let(:product) { Product.new(name: 'Product 1') }

      it 'is not valid' do
        expect(product).to be_invalid
      end

      it 'has error on category' do
        product.valid?

        expect(product.errors[:category].first).to match(/must exist/)
      end
    end

    context 'when product has price less than 1' do
      let(:product) do
        Product.new(
          name: 'Product 1',
          category: category,
          price_in_cents: 0)
      end

      it 'is not valid' do
        expect(product).to be_invalid
      end

      it 'has error on price' do
        product.valid?

        expect(product.errors[:price_in_cents].first).to match(/must be greater than 0/)
      end
    end

    context 'when product has all the required attributes' do
      let(:product) do
        Product.new(
          name: 'Product 1',
          category: category,
          price_in_cents: 200)
      end

      it 'is valid' do
        expect(product).to be_valid
      end
    end
  end
end
