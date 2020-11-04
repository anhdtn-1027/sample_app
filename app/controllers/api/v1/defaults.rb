module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        format :json

        include API::Helpers::RescueHelpers

        helpers API::Helpers::AuthenticateHelpers, API::Helpers::APIHelpers

        helpers do
          def response_success message, data
            {status: "success", data: data.as_json, message: message}
          end
        end
      end
    end
  end
end
