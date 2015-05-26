class OrderItem < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :menu_item, presence: true
  validates :order, presence: true
  
end
