class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: :create

  def new
    super
  end

  def create
    super
  end

  protected

  def after_sign_up_path_for _user
    flash[:success] = t "devise.registrations.signed_up"
    root_path
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User::USER_PARAMS)
  end
end
