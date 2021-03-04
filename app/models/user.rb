class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password, format:{with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/, message: "Include both letters and numbers"} 
  validates :surname, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々]/, message: "Full-width characters"}
  validates :firstname, presence: true, format: {with: /\A[ぁ-んァ-ヶ一-龥々]/, message: "Full-width characters"}
  validates :kana_surname, presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: "Kana surname Full-width katakana characters"}
  validates :kana_firstname, presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: "Kana firstname Full-width katakana characters"}
  validates :birthday, presence: true
end