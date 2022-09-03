class Item < ApplicationRecord

  has_one_attached :image
  has_many :cart_items, dependent: :destroy

  def add_tax_price
        (self.price * 1.08).round
  end

end
