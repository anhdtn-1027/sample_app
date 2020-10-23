module API
  module ApiHelpers
    extend Grape::API::Helpers

    Grape::Entity.format_with :custom_day do |date|
      date.strftime(Settings.date.custom_day) if date
    end
  end
end
