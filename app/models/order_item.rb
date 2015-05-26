class OrderItem < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :menu_item_present
  validate :order_present

  private
  def menu_item_present
    if menu_item.nil?
      errors.add(:menu_item, 'is not valid menu_item.')
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, 'is not a valid order.')
    end
  end
end
