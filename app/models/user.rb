class User < ActiveRecord::Base
  include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable,
         :trackable, :validatable,
         :token_authenticatable
  has_many :orders
  validates :name, presence: true
  
  validates_uniqueness_of :order_acknowledge_email,
            conditions: -> { where.not(order_acknowledge_email: false) }

  after_create :ensure_authentication_token

  scope :clients, -> { where(is_admin: [false, nil]) }
  scope :admins, -> { where(is_admin: true) }

  def admin?
    self.is_admin
  end
  
  def self.notification_email_list
    if (email_list = User.where(is_admin: true, receive_notifications: true).pluck(:email))
      email_list
    else
      ENV['order_receipt_from_email']
    end
       
  end
  
  def self.order_acknowledge_email_address
    # Returns email address (string)
    if (user = User.find_by(is_admin: true, order_acknowledge_email: true))
      user.email
    else
      ENV['order_receipt_from_email']
    end
  end
  
end
