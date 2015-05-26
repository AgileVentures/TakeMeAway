class MenuItem < ActiveRecord::Base
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :menu_categories
  has_and_belongs_to_many :menus
  has_attachment :image, accept: [:jpg, :png, :gif]

  validates :name, presence: true
  validates :price, presence: true
end
