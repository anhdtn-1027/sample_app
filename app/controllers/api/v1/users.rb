module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      before do
        authenticate_user!
      end

      resource :users do
        desc "Return all users"
        get "", root: :users do
          users = User.includes(:microposts)
          data = Entities::User.represent users, except: [:microposts]
          present response_success users: data.as_json
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: :user do
          user = User.find params[:id]
          data = Entities::User.represent user,
                                          except:
                                            [:microposts_count, :created_at]
          present response_success user: data.as_json
        end
      end
    end
  end
end
