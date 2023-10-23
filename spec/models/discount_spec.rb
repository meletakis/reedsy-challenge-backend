require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    let(:category) { FactoryBot.create(:category) }

    context 'when discount has no category' do
      let(:discount) do
        Discount.new(volume: 3, from_num_of_items: 10)
      end

      it 'is not valid' do
        expect(discount).to be_invalid
      end

      it 'has error on category' do
        discount.valid?

        expect(discount.errors[:category].first).to match(/must exist/)
      end
    end

    context 'when discount has volume less than 1' do
      let(:discount) do
        Discount.new(
          category: category,
          from_num_of_items: 10,
          volume: 0)
      end

      it 'is not valid' do
        expect(discount).to be_invalid
      end

      it 'has error on volume' do
        discount.valid?

        expect(discount.errors[:volume].first).to match(/is not included in the list/)
      end
    end

    context 'when discount has from_num_of_items less than 1' do
      let(:discount) do
        Discount.new(
          category: category,
          volume: 2,
          from_num_of_items: 0)
      end

      it 'is not valid' do
        expect(discount).to be_invalid
      end

      it 'has error on from_num_of_items' do
        discount.valid?

        expect(discount.errors[:from_num_of_items].first).to match(/must be greater than 0/)
      end
    end

    context 'when discount has all the required attributes' do
      let(:discount) do
        Discount.new(
          category: category,
          volume: 20,
          from_num_of_items: 200)
      end

      it 'is valid' do
        expect(discount).to be_valid
      end
    end
  end
end
