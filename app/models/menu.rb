class Menu < ActiveRecord::Base
  has_and_belongs_to_many :menu_categories

  validates :start_date, presence: true
  validates :end_date, presence: true
end
