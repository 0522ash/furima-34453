require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/star.png')
  end

  describe '出品機能' do
    context '出品ができる時' do
      it '必須項目が全てあれば登録できること' do
        expect(@item).to be_valid
      end
    end

    context '出品ができない時' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include { "Image can't be blank" }
      end

      it '商品名が必須であること' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.detail = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品の状態についての情報が必須であること' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition Select')
      end

      it '配送料の負担についての情報が必須であること' do
        @item.shipping_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charge Select')
      end

      it '発送元の地域についての情報が必須であること' do
        @item.ship_from_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship from Select')
      end

      it '発送までの日数についての情報が必須であること' do
        @item.guideline_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Guideline Select')
      end

      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '売価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '値段が10000000円以上の場合は登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '１１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it '価格が英数混合では登録できないこと' do
        @item.price = 'test00'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      
      it '価格が半角英語のみでは登録できないこと' do
        @item.price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end

      it 'カテゴリーが1の場合は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it '商品の状態が1の場合は登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition Select')
      end

      it '配送料の負担が1の場合は登録できない' do
        @item.shipping_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charge Select')
      end

      it '発送までの日数が1の場合は登録できない' do
        @item.ship_from_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship from Select')
      end

      it '発送元の地域が1の場合は登録できない' do
        @item.guideline_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Guideline Select')
      end
    end
  end
end
