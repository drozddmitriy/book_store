class Ability
  include CanCan::Ability

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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
      can :cud, OrderItem
      can %i[create update], Address
      can :update, Coupon
      can %i[show update], :checkout
      can %i[create update], Order, user_id: user.id
    else
      can :cud, OrderItem
      can :update, Coupon
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
