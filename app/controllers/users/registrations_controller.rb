class Users::RegistrationsController < Devise::RegistrationsController
  def quik_register
    user = User.new(
      email: params[:user][:email],
      password: Devise.friendly_token.first(Devise.password_length.first)
    )

    if params[:user][:email].present?
      user.confirm
      user.save
      sign_up(:user, user)
      user.send_reset_password_instructions
      redirect_to checkout_path(:addresses)
    else
      redirect_to checkout_path(:login)
    end
  end

  protected

  def update_resource(resource, params)
    user_params[:current_password] ? super : resource.update_without_password(user_params)
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  def user_params
    params.require(:user).permit(:email, :current_password)
  end
end
