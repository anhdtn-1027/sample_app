module DeviseHelper

  def devise_error_messages!
     flash[:error] = resource.errors.full_messages.first if resource.errors.full_messages.present?
  end
end
