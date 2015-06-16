class MenuItemsMenu < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :menu

  validates :daily_stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :menu_item, presence: true
  # validates :menu, presence: true

  def decrement_stock(qty)
    self.decrement!(:daily_stock, qty)
  end

  def increment_stock(qty)
    self.increment!(:daily_stock, qty)
  end

  def active?
    self.daily_stock > 0
  end
end


# menu.menu_items_menus

# menu_item.menu_items_menus = sdfsdf
# menu_item.save

# menu_item.menu_items_menus.menu