class UserService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create
    return if User.find_by(email: params)

    user = User.new(
      email: params,
      password: Devise.friendly_token.first(Devise.password_length.first)
    )
    return if user_valid?(user)

    user.confirm
    user.save
    user
  end

  private

  def user_valid?(user)
    user.valid?
    user.errors.messages[:email].present?
  end
end
