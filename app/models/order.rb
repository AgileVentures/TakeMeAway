class Order < ActiveRecord::Base

  has_and_belongs_to_many :menu_items
  belongs_to :user

  accepts_nested_attributes_for :menu_items
  accepts_nested_attributes_for :user


  STATUS = %w(pending processed canceled)

  validates_presence_of :user

  #validates :pickup_time, on_or_after: lambda { Date.current }
  #PATCHING with validator from 'date_validator' with a quick fix for validation message

  validates :pickup_time, date: { after: Proc.new { Time.now }, message: '%{value} didn\'t pass validation'}
  validates :status, inclusion: Order::STATUS

  scope :canceled, lambda { where(status: 'canceled') }
  scope :pending, lambda { where(status: 'pending') }
  scope :processed, lambda { where(status: 'processed') }


  def total
    if self.menu_items.any?
      self.menu_items.sum(:price).to_f
    end
  end

  def set_status(state)
    self.update_attribute(:status, state)
  end
end
