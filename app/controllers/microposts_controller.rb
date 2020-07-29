class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :new_micropost, only: :create

  def create
    @micropost.image.attach params[:micropost][:image]
    if @micropost.save
      flash[:success] = t "microposts.created_success"
      redirect_to root_url
    else
      @feed_items = get_feed_items
      flash.now[:danger] = t "microposts.created_error"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "microposts.deleted_success"
      redirect_to request.referer || root_url
    else
      flash[:danger] = t "microposts.deleted_error"
      render "static_pages/home"
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOST_PARAMS
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.blank?
  end

  def new_micropost
    @micropost = current_user.microposts.build micropost_params
  end

  def get_feed_items
    current_user.feed(current_user.id).page(params[:page])
                .per Settings.user.per_page
  end
end
