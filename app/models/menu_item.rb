class MenuItem < ActiveRecord::Base
  has_one :image, dependent: :destroy
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :menu_categories
  has_and_belongs_to_many :menus

  accepts_nested_attributes_for :image, allow_destroy: true

  validates :name, presence: true
  validates :price, presence: true
end
