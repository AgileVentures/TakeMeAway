class Menu < ActiveRecord::Base
  has_many :menu_items_menus
  has_many :menu_items, through: :menu_items_menus

  accepts_nested_attributes_for :menu_items_menus, reject_if: :all_blank, allow_destroy: :true


  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :this_week, lambda { where(start_date:Date.today.all_week).order('start_date') }
  
  def self.item_in_menu?(item_to_check)
    # Checks whether the input menu_item is included in any current or future menu.
    
    menus = Menu.where(["end_date >= ?", Date.today])
    menus.each {|menu| return true if menu.menu_items.include?(item_to_check)}
    false
  end
end
