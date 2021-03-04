class CreateShipFromIds < ActiveRecord::Migration[6.0]
  def change
    create_table :ship_from_ids do |t|

      t.timestamps
    end
  end
end
