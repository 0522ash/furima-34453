class CustomerinfoShippinginfo
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :ship_from_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "Input correctly"}
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/}
    validates :address
    validates :phone_number, format: {with: /\A[0-9]{11}+\z/, message: "Input only number"}
  end



  validates :ship_from_id, numericality: { other_than: 1, message: 'Select' }

  def save
    customerinfo = Customerinfo.create(item_id: item_id, user_id: user_id)
    Shippinginfo.create(postal_code: postal_code, ship_from_id: ship_from_id, city: city, address: address, building_name: building_name, phone_number: phone_number, customerinfo_id: customerinfo.id)
  end
end
