class Menu < ActiveRecord::Base
  validates :start_date, presence: true
  validates :end_date, presence: true
end
