class Menu < ActiveRecord::Base
  has_many :menu_items_menus, inverse_of: :menu
  # 'inverse_of' allows access to in-memory representation of menu object for
  # validation of menu_items_menu object (before either are saved and hence access
  # via DB is not possible)
  
  has_many :menu_items, through: :menu_items_menus

  accepts_nested_attributes_for :menu_items_menus, reject_if: :all_blank, allow_destroy: :true


  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :this_week, lambda { where(start_date:Date.today.all_week).order('start_date') }
  
  def self.item_in_menu?(item_to_check)
    # Checks whether the input menu_item is included in any current or future menu.

    item_to_check.menus.each do |menu|
      return true if menu.end_date >= Date.today
    end
    false
  end
end
