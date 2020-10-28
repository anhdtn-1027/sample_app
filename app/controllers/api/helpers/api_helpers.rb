module API
  module Helpers
    module APIHelpers
      extend Grape::API::Helpers

      Grape::Entity.format_with :custom_day do |date|
        date&.strftime Settings.date.custom_day
      end
    end
  end
end
