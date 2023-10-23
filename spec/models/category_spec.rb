require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    context 'when category has no name' do
      let(:category) { Category.new(name: '') }

      it 'is not valid' do
        expect(category).to be_invalid
      end

      it 'has error on name' do
        category.valid?

        expect(category.errors[:name].first).to match(/can\'t be blank/)
      end
    end

    context 'when category has all the required attributes' do
      let(:category) do
        Category.new(name: 'Category 1')
      end

      it 'is valid' do
        expect(category).to be_valid
      end
    end
  end
end
