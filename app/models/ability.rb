class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
        can :read, ActiveAdmin::Page, name: 'Dashboard'
      else
        #can :read, :all
        can :create, Order
        can :read, ActiveAdmin::Page, name: 'Dashboard'
      end
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
