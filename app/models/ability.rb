class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)

      can :read, :all
      can [:home], :page

      if user.admin?
        can :manage, :all
      elsif user.is_a?(User) && user.persisted?
        can :manage, User, id: user.id
        can :create, Review, user_id: user.id
        can %i[create update destroy], LineItem
        can %i[create update], Address
        can :update, Coupon
        # can :read, :all
      else
        # can :create, LineItem
        can %i[create update destroy], LineItem
        can :update, Coupon
      end
  end
end
