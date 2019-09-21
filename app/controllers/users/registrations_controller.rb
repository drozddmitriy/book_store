class Users::RegistrationsController < Devise::RegistrationsController

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
