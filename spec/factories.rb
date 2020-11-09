FactoryBot.define do
  factory :discount do
    rate { rand * 100 }
    quantity { rand(1..10) }
    merchant
  end

  factory :user do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    email { Faker::Internet.email }
    password { '12345' }

    factory :merchant_employee do
      role { 1 }
      merchant

      trait :with_discounts do
        transient do
          discounts { 3 }
        end

        after :create do |user, evaluator|
          create_list(:discount, evaluator.discounts, merchant: user.merchant)
        end
      end
    end
  end

  factory :merchant do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }

    trait :with_employee do
      after :create do |merchant|
        create(:merchant_employee, merchant: merchant)
      end
    end

    trait :with_discounts do
      transient do
        discounts { 3 }
      end

      after :create do |merchant, evaluator|
        create_list(:discount, evaluator.discounts, merchant: merchant)
      end
    end

    trait :with_items do
      transient do
        items { 3 }
      end

      after :create do |merchant, evaluator|
        create_list(:item, evaluator.items, merchant: merchant)
      end
    end
  end

  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price }
    image { 'https://placeimg.com/640/480/animals' }
    inventory { rand(10..50) }
    merchant
  end
end
