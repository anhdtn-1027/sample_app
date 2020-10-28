module API
  module Helpers
    module AuthenticateHelpers
      def authenticate_user!
        token = request.headers["Jwt-Token"]
        user_id = Authentication.decode(token)["user_id"] if token
        @current_user = User.find user_id
        return if @current_user.present?

        api_error!("You need to log in to use the app", "failure", 401, {})
      end

      def api_error! message, error_code, status, header
        error!({message: message, code: error_code}, status, header)
      end
    end
  end
end
