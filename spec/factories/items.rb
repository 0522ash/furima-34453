FactoryBot.define do
  factory :item do
    title { Faker::Lorem.sentence }
    detail { Faker::Lorem.sentence }
    association :user
    category_id           { 2 }
    condition_id          { 2 }
    shipping_charge_id    { 2 }
    ship_from_id          { 2 }
    guideline_id          { 2 }
    price                 { 5000 }

    after(:build) do |customerinfo_shippinginfo|
      customerinfo_shippinginfo.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
