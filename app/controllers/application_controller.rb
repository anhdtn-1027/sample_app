class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_user!, except: %i(help about contact)

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.require_login"
    redirect_to login_url
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.notfound", id: params[:id]
    redirect_to root_path
  end
end
