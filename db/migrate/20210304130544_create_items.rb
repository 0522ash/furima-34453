class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.text :detail, null: false
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_charge_id, null: false
      t.integer :ship_from_id, null: false
      t.integer :guideline_id, null: false
      t.integer :price, null: false
      t.references :user, foreign_key: true


      t.timestamps
    end
  end
end
