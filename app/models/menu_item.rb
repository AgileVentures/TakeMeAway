class MenuItem < ActiveRecord::Base
has_one :image
has_many :ordered_tiems
has_many :orders, through :ordered_items
has_many :menu_categories
has_many :menus, through :menu_categories

validates :name, presence: true
validates :price, presence: true
end
