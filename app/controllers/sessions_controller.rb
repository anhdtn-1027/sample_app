class SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for user
    flash[:success] = t "devise.sessions.signed_in"
    user_path user
  end

  def after_sign_out_path_for _user
    flash[:success] = t "devise.sessions.signed_out"
    new_user_session_path
  end
end
