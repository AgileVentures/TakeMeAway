class MenuCategory < ActiveRecord::Base
  has_and_belongs_to_many :menu_items

  validates_presence_of :name
end
