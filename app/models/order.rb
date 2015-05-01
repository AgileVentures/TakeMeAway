class Order < ActiveRecord::Base
  has_and_belongs_to_many :menu_items
  belongs_to :user

  validates_presence_of :user

  validates_date :pickup_time, on_or_after: lambda { Date.current }
end
