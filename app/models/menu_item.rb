class MenuItem < ActiveRecord::Base
  has_one :image
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :menu_categories

  validates :name, presence: true
  validates :price, presence: true
end
