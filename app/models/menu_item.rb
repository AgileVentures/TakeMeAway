class MenuItem < ActiveRecord::Base
  
  before_destroy :can_destroy?
  
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :menu_items_menus
  has_many :menus, through: :menu_items_menus

  has_and_belongs_to_many :menu_categories

  has_attachment :image, accept: [:jpg, :png, :gif]
  
  STATUS = ['active', 'inactive']
  
  def self.active_menu_items
    MenuItem.where(status: 'active')
  end
    
  validates :name, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates_inclusion_of :status, in: MenuItem::STATUS,
                          message: 'is not a valid status'
                          
  validate :inactive_item_not_in_menu, on: :update
                          
  def inactive_item_not_in_menu
    if self.status == 'inactive' && Menu.item_in_menu?(self)
      errors[:status] << 'cannot be inactive since product is included in one or more menus'
    end
  end
  
  def can_menu_item_be_destroyed?
    not (Menu.item_in_menu?(self) || Order.item_in_order?(self))
  end
  
  private
  
  def can_destroy?
    return true if can_menu_item_be_destroyed?
    # ActiveAdmin is not displaying errors hash upon attempted delete.  However, we have to
    # add a record to the hash in order to have the callback cease execution upon returning false
    errors[:item] << 'Item cannot be destroyed'
    return false
  end
  
end
