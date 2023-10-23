FactoryBot.define do
  factory :discount do
    category
    volume { 2 }
    from_num_of_items { 10 }

    trait :enabled do
      enabled { true }
    end
  end
end
