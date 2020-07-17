class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      activate user
    else
      flash.now[:danger] = t "users.invalid_user"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def activate user
    if user.activated?
      log_in user
      check_remember user
      flash[:success] = t "users.success_user"
      redirect_back_or user
    else
      flash[:warning] = t "users.mailer.activate_warning"
      redirect_to root_url
    end
  end
end
