class MenuCategory < ActiveRecord::Base
  belongs_to :menu
  belongs_to :menu_item
  
  validates_presence_of :name
end
