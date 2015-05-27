class MenuItemsMenu < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :menu

  validates :daily_stock, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :menu_item, presence: true
  validates :menu, presence: true
end
