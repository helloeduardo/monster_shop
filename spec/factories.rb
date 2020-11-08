FactoryBot.define do
  factory :discount do
    rate { 1.5 }
    quantity { 1 }
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
    end
  end

  factory :merchant do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end
end
