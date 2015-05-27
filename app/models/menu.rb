class Menu < ActiveRecord::Base
  has_many :menu_item_menus
  has_many :menu_items, through: :menu_item_menus

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :this_week, lambda { where(start_date:Date.today.all_week).order('start_date') }
end
