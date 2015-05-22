class Order < ActiveRecord::Base

  has_and_belongs_to_many :menu_items
  belongs_to :user

  STATUS = %w(pending processed canceled)

  validates_presence_of :user

  #validates :pickup_time, on_or_after: lambda { Date.current }
  #PATCHING with validator from 'date_validator' with a quick fix for validation message

  validates :pickup_time, date: { after: Proc.new { Time.now }, message: '%{value} didn\'t pass validation'}
  validates :status, inclusion: Order::STATUS



  def total
    if self.menu_items.any?
      self.menu_items.sum(:price).to_f
    end
  end
end
