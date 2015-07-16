class Menu < ActiveRecord::Base
  has_many :menu_items_menus, inverse_of: :menu, dependent: :destroy
  # 'inverse_of' allows access to in-memory representation of menu object for
  # validation of menu_items_menu object (before either are saved and hence access
  # via DB is not possible)
  
  has_many :menu_items, through: :menu_items_menus

  accepts_nested_attributes_for :menu_items_menus, reject_if: :all_blank, allow_destroy: :true

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate  :end_date_not_earlier_than_start_date
  
  def end_date_not_earlier_than_start_date
    if end_date && (end_date < start_date)
      errors[:end_date] << 'must be not be earlier than start date'
    end 
  end

  scope :this_week, -> { where("start_date <= ? AND end_date >= ?", 
                            Date.today.end_of_week, Date.today) }

  def self.item_in_menu?(item_to_check)
    # Checks whether the input menu_item is included in any current or future menu.
    item_to_check.menus.each do |menu|
      return true if menu.end_date >= Date.today
    end
    false
  end
end
