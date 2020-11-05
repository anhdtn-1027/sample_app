module API
  module Helpers
    module RescueHelpers
      included do
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

        rescue_from JWT::VerificationError do |e|
          error_response(message: e.message, status: 500)
        end

        rescue_from JWT::DecodeError do |e|
          error_response(message: e.message, status: 500)
        end

        rescue_from :all do |e|
          raise e if Rails.env.development?

          error_response(message: e.message, status: 500)
        end
      end
    end
  end
end
