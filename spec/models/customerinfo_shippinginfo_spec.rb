require 'rails_helper'
RSpec.describe CustomerinfoShippinginfo, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @customerinfo_shippinginfo = FactoryBot.build(:customerinfo_shippinginfo, user_id: @user.id, item_id: @item.id)
    sleep(0.1)
  end

  describe '購入情報の保存' do
    context '保存できるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@customerinfo_shippinginfo).to be_valid
      end

      context '保存できない時' do
        it '配送先の情報として、郵便番号が必須であること' do
          @customerinfo_shippinginfo.postal_code = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Postal code can't be blank"), ("Postal code Input correctly")
        end

        it '配送先の情報として、都道府県が必須であること' do
          @customerinfo_shippinginfo.ship_from_id = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Ship from Select")
        end

        it '配送先の情報として、市区町村が必須であること' do
          @customerinfo_shippinginfo.city = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("City can't be blank")
        end

        it '配送先の情報として、番地が必須であること' do
          @customerinfo_shippinginfo.address = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Address can't be blank")
        end

        it '配送先の情報として、電話番号が必須であること' do
          @customerinfo_shippinginfo.phone_number = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Phone number can't be blank"), ("Phone number Input only number")
        end
        
        it '郵便番号の保存にはハイフンが必要であること（123-4567となる）' do
          @customerinfo_shippinginfo.postal_code = '1001000'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Postal code Input correctly")
        end

        it '郵便番号は全角数字だと保存できないこと' do
          @customerinfo_shippinginfo.postal_code = '１００ー１００００'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Postal code Input correctly")
        end

        it '郵便番号は文字だと保存できないこと' do
          @customerinfo_shippinginfo.postal_code = 'aaa-aaaa'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Postal code Input correctly")
        end
      
        it '電話番号は11桁以内の文字だと保存できないこと' do
          @customerinfo_shippinginfo.phone_number = 'aaaaaaaaaaa'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Phone number Input only number")
        end

        it '電話番号は11桁以内の全角の数字だと保存できないこと' do
          @customerinfo_shippinginfo.phone_number = '０９０１２３４５６７８'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Phone number Input only number")
        end
      
      
      # 購入が完了したら、トップページまたは購入完了ページに遷移すること
      
      
      # エラーハンドリングができていること（入力に問題がある状態で「購入」ボタンが押された場合、情報は受け入れられず、購入ページでエラーメッセージが表示されること）
      
      
      # エラーハンドリングの際、1つエラーに対して同じエラーメッセージが重複して表示されないこと
      
      
      # 売却済みの商品は、画像上に『sold out』の文字が表示されるようになっていること（商品一覧機能）
      
      
      # 売却済みの商品は、画像上に『sold out』の文字が表示されるようになっていること（商品詳細機能）
      
      
      # ログイン状態の出品者でも、売却済みの商品に対しては「編集・削除ボタン」が表示されないこと（商品詳細機能）
      
      
      # ログイン状態の出品者以外のユーザーでも、売却済みの商品に対しては「購入画面に進む」ボタンが表示されないこと（商品詳細機能）
      
      
      # ログイン状態の出品者であっても、URLを直接入力して自身の売却済み商品の商品情報編集ページへ遷移しようとすると、トップページに遷移すること（商品情報編集機能）


      # クレジットカード決済ができること
      
      
      # クレジットカードの情報は購入の都度入力させること
      
      
      # クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと
      end
    end
  end
end
