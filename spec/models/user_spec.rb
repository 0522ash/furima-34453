require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '新規登録がうまくいくとき' do
      it 'ニックネーム、メールアドレス、パスワード、確認のパスワード、名字、名前、名字（フリガナ）、名前（フリガナ）、生年月日があれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
        @user.password = 'test00'
        @user.password_confirmation = 'test00'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
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
        user = FactoryBot.create(:user)
        another_user = FactoryBot.build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'kkkgmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", 'Password Include both letters and numbers')
      end
      it 'パスワードが6文字以下であれば登録できないこと' do
        @user.password = 'aaa00'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
        @user.password = 'ＡＡＡ０００'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it 'パスワードは、確認用を含めて2回入力すること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード（確認用）は、値の一致が必須であること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '半角英語のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
      it '半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end
    end


    describe '新規登録/本人情報確認' do
      it 'ユーザー本名は、名字が必須であること' do
        @user.surname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname can't be blank")
      end
      it 'ユーザー本名は、名前が必須であること' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end
      it 'ユーザー名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.surname = 'AAA'
        @user.valid?
        expect(@user.errors.full_messages).to include('Surname Full-width characters')
      end
      it 'ユーザー名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.firstname = 'AAA'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname Full-width characters')
      end
      it 'ユーザーのフリガナは、名字が必須であること' do
        @user.kana_surname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana surname can't be blank")
      end
      it 'ユーザーのフリガナ（名字）は、カタカナ以外の全角文字だと登録できないこと' do
        @user.kana_surname = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana surname Full-width katakana characters")
      end
      it 'ユーザーのフリガナは、名前が必須であること' do
        @user.kana_firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana firstname can't be blank")
      end
      it 'ユーザーのフリガナ（名前）は、カタカナ以外の全角文字だと登録できないこと' do
        @user.kana_firstname = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana firstname Full-width katakana characters")
      end

      context  'カタカナ以外の全角文字だと登録できないこと' do
        it 'ユーザー名字のフリガナは、全角（カタカナ）での入力が必須であること' do
          @user.kana_surname = 'ｱｱｱ'
          @user.valid?
          expect(@user.errors.full_messages).to include("Kana surname Full-width katakana characters")
        end
        it 'ユーザー名前のフリガナは、全角（カタカナ）での入力が必須であること' do
          @user.kana_firstname = 'ｲｲｲ'
          @user.valid?
          expect(@user.errors.full_messages).to include("Kana firstname Full-width katakana characters")
        end
      end

      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
