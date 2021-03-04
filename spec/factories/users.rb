FactoryBot.define do
  factory :user do
    nickname              { 'abe' }
    email                 { 'kkk@gmail.com' }
    password              { 'aaa000' }
    encrypted_password    { 'aaa000' }
    surname               { '山田' }
    firstname             { '太郎' }
    kana_surname          { 'ヤマダ' }
    kana_firstname        { 'タロウ' }
    birthday              { '2000-01-01' }
  end
end
