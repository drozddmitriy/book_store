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
    user.valid?
    return if user.errors.messages[:email].present?

    user.confirm
    user.save
    user
  end
end
