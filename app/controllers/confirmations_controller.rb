class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for resource_name, resource
    sign_in resource # In case you want to sign in the user
    root_path
  end

  def after_resending_confirmation_instructions_path_for resource_name
    is_navigational_format? ? new_session_path(resource_name) : '/'
  end
end
