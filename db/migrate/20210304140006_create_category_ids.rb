class CreateCategoryIds < ActiveRecord::Migration[6.0]
  def change
    create_table :category_ids do |t|
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
