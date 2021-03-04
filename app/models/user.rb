class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :surname, format: { with: /\A[ぁ-んァ-ヶ一-龥々]/, message: 'Full-width characters' }
    validates :firstname, format: { with: /\A[ぁ-んァ-ヶ一-龥々]/, message: 'Full-width characters' }
    validates :kana_surname, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' }
    validates :kana_firstname,format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' }
    validates :birthday
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: 'Include both letters and numbers' }
  end
end
