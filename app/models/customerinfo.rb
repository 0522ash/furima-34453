class Customerinfo < ApplicationRecord
  has_one :shippinginfo
  belongs_to :item
  belongs_to :user
end
