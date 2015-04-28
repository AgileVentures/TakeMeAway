class MenuCategory < ActiveRecord::Base
  has_many_and_belongs_to :menus
  has_many_and_belongs_to :menu_items
  
  validates_presence_of :name
end
