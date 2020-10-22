module API
  module Entities
    include API::ApiHelpers

    class User < Grape::Entity
      expose :id
      expose :name
      expose :email
      expose :microposts, using: Entities::Micropost
      expose :created_at, format_with: :custom_day
      expose :micropost_count do |user|
        user.microposts.size
      end
    end
  end
end
