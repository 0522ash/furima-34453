FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.free_email }
    nickname              { 'aaaaa' }
    password              { 'test00' }
    password_confirmation { 'test00' }
    birthday              { '2000-01-01' }
    surname               { 'てすと' }
    firstname             { '太郎' }
    kana_surname          { 'テスト' }
    kana_firstname        { 'タロウ' }
  end
end
