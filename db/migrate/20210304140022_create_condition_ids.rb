class CreateConditionIds < ActiveRecord::Migration[6.0]
  def change
    create_table :condition_ids do |t|

      t.timestamps
    end
  end
end
