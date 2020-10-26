module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        format :json

        helpers API::Helpers::AuthenticateHelpers, API::Helpers::APIHelpers

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from Grape::Exceptions::ValidationErrors do |e|
          error_response(message: e.message, status: 400)
        end

        rescue_from ArgumentError do |e|
          error_response(message: e.message, status: 400)
        end

        rescue_from :all do |e|
          raise e if Rails.env.development?

          error_response(message: e.message, status: 500)
        end

        helpers do
          def response_success message, data
            {status: "success", data: data.as_json, message: message}
          end
        end
      end
    end
  end
end
