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

  describe '#get_price_with_discount' do
    RSpec.shared_examples 'price without any discount' do |quantity|
      it 'returns the price multiplied with quantity' do
        expect(
          product.get_price_with_discount(quantity)
        ).to eq(product_price * quantity)
      end
    end

    let(:product_price) { 100 }
    let(:product) do
      FactoryBot.create(:product, price_in_cents: product_price)
    end

    context 'when there is no discount' do
      include_examples 'price without any discount', 2
    end

    context "when there is a discount in product's category" do
      let!(:discount) do
        FactoryBot.create(
          :discount,
          category: product.category,
          from_num_of_items: 1,
        )
      end

      context 'but it is disabled' do
        include_examples 'price without any discount', 2
      end

      context 'and it is enabled' do
        let!(:discount) do
          FactoryBot.create(
            :discount,
            :enabled,
            volume: 2,
            category: product.category,
            from_num_of_items: 10,
          )
        end

        context 'but given quantity is not enough for the discount' do
          include_examples 'price without any discount', 5
        end

        context 'and given quantity is enough for the discount' do
          it 'returns price with discount' do
            expect(product.get_price_with_discount(20)).to eq(1960)
          end
        end
      end
    end

    context 'when there are many discounts enabled for a category' do
      let!(:discount_1) do
        FactoryBot.create(
          :discount,
          :enabled,
          volume: 2,
          category: product.category,
          from_num_of_items: 10,
        )
      end

      let!(:discount_2) do
        FactoryBot.create(
          :discount,
          :enabled,
          volume: 4,
          category: product.category,
          from_num_of_items: 20,
        )
      end

      context 'and given quantity is enough for all discounts' do
        it 'selects the biggest discount' do
          expect(product.get_price_with_discount(20)).to eq(1920)
        end
      end
    end
  end
end
