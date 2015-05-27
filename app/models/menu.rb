class Menu < ActiveRecord::Base
  has_and_belongs_to_many :menu_items

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :this_week, lambda { where(start_date:Date.today.all_week).order('start_date') }
end
