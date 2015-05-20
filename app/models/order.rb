class Order < ActiveRecord::Base

  has_and_belongs_to_many :menu_items
  belongs_to :user

  validates_presence_of :user

  validates :pickup_time, date: { after: Proc.new { Time.now }, message: '%{value} didn\'t pass validation'}

end
