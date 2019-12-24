class Ability
  include CanCan::Ability

  # rubocop:disable Metrics/MethodLength
  def initialize(user)
    alias_action :create, :update, :destroy, to: :cud
    user ||= User.new
    can :read, :all
    can :home, :page

    if user.admin?
      can :manage, :all
    elsif user.is_a?(User) && user.persisted?
      can :manage, User, id: user.id
      can :create, Review, user_id: user.id
      can :cud, LineItem
      can %i[create update], Address
      can :update, Coupon
      can %i[show update], :checkout
      can %i[create update], Order, user_id: user.id
    else
      can :cud, LineItem
      can :update, Coupon
    end
  end
  # rubocop:enable Metrics/MethodLength
end
