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

  after_create :ensure_authentication_token

  scope :clients, -> { where.not(is_admin: true) }
  scope :admins, -> { where(is_admin: true) }

  def admin?
    self.is_admin
  end

  def self.find_for_authentication conditions={}
    where("email ILIKE ?", conditions[:email]).where("authentication_token LIKE ?", conditions[:token]).first
  end
end
