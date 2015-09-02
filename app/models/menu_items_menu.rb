class MenuItemsMenu < ActiveRecord::Base
  belongs_to :menu_item
  belongs_to :menu
  
  before_create :set_quantity_sold
  def set_quantity_sold
    self.quantity_sold = 0
    self.quantity_sold_date = Date.today
  end
  
  validates :daily_stock, presence: true, 
        numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :menu_item, presence: true
  validates :menu, presence: true
  
  validate :item_not_in_overlapping_menu
  
  def item_not_in_overlapping_menu
    if (err_msg = overlapping_menu)
      errors[:item] << err_msg
    end
  end
  
  def overlapping_menu
    # Checks whether menu_item associated with 'self' is also included
    # in any "overlapping" menu ("overlap" means that the two menus span one or
    # more common days and include one or more common items)
    
    return nil unless self.menu_item && self.menu
    
    overlap_count = 0
    overlap = ""
    this_menu = self.menu
    
    self.menu_item.menus.each do |other_menu|
      next if this_menu.id && this_menu.id == other_menu.id
      # Check if other_menu overlaps this_menu and is not ended
      if this_menu.start_date <= other_menu.end_date && 
         this_menu.end_date   >= other_menu.start_date &&
         other_menu.end_date >= Date.today
        overlap_count += 1
        overlap += (overlap.empty? ? "'#{other_menu.title}'" : ", '#{other_menu.title}'")
      end
    end
    
    if overlap_count == 1
      return "'#{self.menu_item.name}' is included in overlapping menu #{overlap}"
    elsif overlap_count > 1
      return "'#{self.menu_item.name}' is included in overlapping menus: #{overlap}"
    end
    nil
  end

  def decrement_quantity_sold(qty)
    self.decrement!(:quantity_sold, qty)
  end

  def increment_quantity_sold(qty)
    self.increment!(:quantity_sold, qty)
  end

  def active?
    # If this is the first time today that this menu_items_menu is to be included in a menu,
    # reset quantity_sold (for today) to zero
    if self.quantity_sold_date != (date_today = Date.today)
      self.quantity_sold = 0
      self.quantity_sold_date = date_today
    end
    # 'daily_stock' is the maximum quantity of the item that can sold on any given day.
    self.quantity_sold < self.daily_stock
  end
end
