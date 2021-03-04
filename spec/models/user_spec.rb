require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user
      user = FactoryBot.create(:user)
      another_user = FactoryBot.build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include('has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'kkkgmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors[:password]).to include("can't be blank", 'Include both letters and numbers')
    end
    it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
      user = FactoryBot.build(:user, password: 'aaa000', encrypted_password: 'aaa000')
      expect(user).to be_valid
    end
    it 'パスワードが6文字以下であれば登録できないこと' do
      @user.password = 'aaa00', encrypted_password = 'aaa00'
      @user.valid?
      expect(@user.errors[:encrypted_password]).to include
    end
    it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
      @user.password = 'ＡＡＡ０００'
      @user.valid?
      expect(@user.errors[:family_name]).to include
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.encrypted_password = ''
      @user.valid?
      expect(@user.errors[:encrypted_password]).to include
    end
    it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    before do
      @user = FactoryBot.build(:user)
    end
    it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
      @user.surname = ''
      @user.valid?
      expect(@user.errors[:surname]).to include("can't be blank")
      @user.firstname = ''
      @user.valid?
      expect(@user.errors[:firstname]).to include("can't be blank")
    end
    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.surname = 'AAA'
      @user.valid?
      expect(@user.errors[:surname]).to include('Full-width characters')
      @user.firstname = 'AAA'
      @user.valid?
      expect(@user.errors[:firstname]).to include('Full-width characters')
    end
    it 'ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること' do
      @user.kana_surname = ''
      @user.valid?
      expect(@user.errors[:kana_surname]).to include("can't be blank")
      @user.kana_firstname = ''
      @user.valid?
      expect(@user.errors[:kana_firstname]).to include("can't be blank")
    end
    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.kana_surname = 'ｱｱｱ'
      @user.valid?
      expect(@user.errors[:kana_surname]).to include('Full-width katakana characters')
      @user.kana_firstname = 'ｲｲｲ'
      @user.valid?
      expect(@user.errors[:kana_firstname]).to include('Full-width katakana characters')
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors[:birthday]).to include("can't be blank")
    end
  end
end
