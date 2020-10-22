module API
  module V1
    class Base < Grape::API
      error_formatter :json, API::ErrorFormatter
      mount V1::Auth
      mount V1::Users

      # mount API::V1::AnotherResource
    end
  end
end
