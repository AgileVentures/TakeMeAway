class MenuItem < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :menu_items_menus
  has_many :menus, through: :menu_items_menus

  has_and_belongs_to_many :menu_categories

  has_attachment :image, accept: [:jpg, :png, :gif]

  validates :name, presence: true
  validates :price, presence: true
end
