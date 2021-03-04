class CreateShippingChargeIds < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_charge_ids do |t|

      t.timestamps
    end
  end
end
