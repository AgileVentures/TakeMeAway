class Menu < ActiveRecord::Base
  has_many :menu_items_menus
  has_many :menu_items, through: :menu_items_menus

  accepts_nested_attributes_for :menu_items_menus, reject_if: :all_blank, allow_destroy: :true


  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :this_week, lambda { where(start_date:Date.today.all_week).order('start_date') }

  # before_create :do_this
  # before_validation :do_this
  # after_save :do_this

  def do_this
    puts "--------debug---------"
    _self = self
    binding.pry
    puts
  end
end
