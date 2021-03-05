require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  ログイン状態のユーザーのみ、商品出品ページへ遷移できること
  ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移すること
  商品画像を1枚つけることが必須であること
  商品名が必須であること
  商品の説明が必須であること
  カテゴリーの情報が必須であること
  商品の状態についての情報が必須であること
  配送料の負担についての情報が必須であること
  発送元の地域についての情報が必須であること
  発送までの日数についての情報が必須であること
  販売価格についての情報が必須であること
  販売価格は、¥300~¥9,999,999の間のみ保存可能であること
  販売価格は半角数字のみ保存可能であること
  入力された販売価格によって、販売手数料や販売利益の表示が変わること
  必要な情報を適切に入力すると、商品情報がデータベースに保存されること
  エラーハンドリングができていること（入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること）
  エラーハンドリングの際、1つのエラーに対して同じエラーメッセージが重複して表示されないこと
end
