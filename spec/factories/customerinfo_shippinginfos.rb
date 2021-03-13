FactoryBot.define do
  factory :customerinfo_shippinginfo do
    postal_code            { '123-4567' }
    city                   { '東京都' }
    address                { '1-1' }
    building_name          { '東京ハイツ' }
    phone_number           { '09012345678' }
    ship_from_id           { 2 }
    token                  { 'tok_abcdefghijk00000000000000000' }
  end
end
