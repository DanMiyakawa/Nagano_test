class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :cart_items, dependent: :destroy
   has_many :shipping_address, dependent: :destroy
   has_many :orders, dependent: :destroy

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + full_name
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + " " + self.first_name_kana
  end

end
