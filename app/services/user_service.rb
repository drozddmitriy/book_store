class UserService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def create
    user = User.new(
      email: params,
      password: Devise.friendly_token.first(Devise.password_length.first)
    )
    user.confirm
    user.save
    user
  end
end
