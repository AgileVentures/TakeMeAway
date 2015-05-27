class Order < ActiveRecord::Base
  has_many :order_items
  has_many :menu_items, through: :order_items
  belongs_to :user

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: :true
  accepts_nested_attributes_for :user

  STATUS = %w(pending processed canceled)

  validates_presence_of :user

  validates :pickup_time, date: { after: Proc.new { Time.now }, message: '%{value} didn\'t pass validation'}
  validates :status, inclusion: Order::STATUS

  scope :canceled, lambda { where(status: 'canceled') }
  scope :pending, lambda { where(status: 'pending') }
  scope :processed, lambda { where(status: 'processed') }


  def total
    if self.order_items.any?
      @total = 0
      self.order_items.each {|item| @total += item.menu_item.price.to_f }
      @total
    end
  end

  def set_status(state)
    self.update_attribute(:status, state)
  end
end
