class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'Include both letters and numbers' }
  end
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'Full-width characters' } do
    validates :surname
    validates :firstname
  end
  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' } do
    validates :kana_surname
    validates :kana_firstname
  end
end
