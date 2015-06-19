class MenuItem < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :menu_items_menus
  has_many :menus, through: :menu_items_menus

  has_and_belongs_to_many :menu_categories

  has_attachment :image, accept: [:jpg, :png, :gif]
  
  @@valid_status_values = ['active', 'inactive']
  def self.status_values
    @@valid_status_values
  end
  
  def self.active_menu_items
    MenuItem.where(status: 'active')
  end
    
    
  validates :name, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates_inclusion_of :status, in: @@valid_status_values,
                          message: 'is not a valid status'
end
