FactoryBot.define do
  factory :product do
    category
    sequence(:name) { |n| "Product #{n}" }
    sequence(:price_in_cents) { |n| n * 100 }
  end
end
