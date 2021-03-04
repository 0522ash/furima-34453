class CreateGuidelineIds < ActiveRecord::Migration[6.0]
  def change
    create_table :guideline_ids do |t|

      t.timestamps
    end
  end
end
