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

      it '建物名が無くても登録できること' do
        @customerinfo_shippinginfo.building_name = ''
        @customerinfo_shippinginfo.valid?
        expect(@customerinfo_shippinginfo).to be_valid
      end

      context '保存できない時' do
        it '配送先の情報として、郵便番号が必須であること' do
          @customerinfo_shippinginfo.postal_code = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include "Postal code can't be blank", 'Postal code Input correctly'
        end

        it '配送先の情報として、都道府県が必須であること' do
          @customerinfo_shippinginfo.ship_from_id = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Ship from Select')
        end

        it '都道府県のidが1の場合は登録できないこと' do
          @customerinfo_shippinginfo.ship_from_id = 1
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Ship from Select')
        end

        it '配送先の情報として、市区町村が必須であること' do
          @customerinfo_shippinginfo.city = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include("City can't be blank")
        end

        it '配送先の情報として、番地が必須であること' do
          @customerinfo_shippinginfo.address = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include("Address can't be blank")
        end

        it '配送先の情報として、電話番号が必須であること' do
          @customerinfo_shippinginfo.phone_number = ''
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include "Phone number can't be blank"
        end

        it '郵便番号の保存にはハイフンが必要であること（123-4567となる）' do
          @customerinfo_shippinginfo.postal_code = '1001000'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Postal code Input correctly')
        end

        it '郵便番号は全角数字だと保存できないこと' do
          @customerinfo_shippinginfo.postal_code = '１００ー１００００'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Postal code Input correctly')
        end

        it '郵便番号は文字だと保存できないこと' do
          @customerinfo_shippinginfo.postal_code = 'aaa-aaaa'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Postal code Input correctly')
        end

        it '電話番号は11桁以内の文字だと保存できないこと' do
          @customerinfo_shippinginfo.phone_number = 'aaaaaaaaaaa'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Phone number Input only number')
        end

        it '電話番号は11桁以内の全角の数字だと保存できないこと' do
          @customerinfo_shippinginfo.phone_number = '０９０１２３４５６７８'
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include('Phone number Input only number')
        end

        it 'tokenが空では登録できないこと' do
          @customerinfo_shippinginfo.token = nil
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include("Token can't be blank")
        end

        it 'user_idが無いと登録できないこと' do
          @customerinfo_shippinginfo.user_id = nil
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("User can't be blank")
        end

        it 'item_idが無いと登録できないこと' do
          @customerinfo_shippinginfo.item_id = nil
          @customerinfo_shippinginfo.valid?
          expect(@customerinfo_shippinginfo.errors.full_messages).to include ("Item can't be blank")
        end
      end
    end
  end
end
