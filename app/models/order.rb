class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }

  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details

end
