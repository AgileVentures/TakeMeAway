class User < ActiveRecord::Base
  include TokenAuthenticatable
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable,
         :trackable, :validatable
  has_many :orders
  validates :name, presence: true

  after_create :ensure_authentication_token

  scope :clients, -> { where.not(is_admin: true) }
  scope :admins, -> { where(is_admin: true) }

  def admin?
    self.is_admin
  end
end
