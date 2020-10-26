module API
  module V1
    class Microposts < Grape::API
      include API::V1::Defaults

      before do
        authenticate_user!
      end

      helpers do
        def micropost_params
          ActionController::Parameters.new(params[:micropost]).permit :content
        end
      end

      resource :microposts do
        desc "Create micropost"
        params do
          requires :micropost, type: Hash do
            requires :content, type: String, desc: "micropost content"
          end
        end
        post do
          micropost = @current_user.microposts.create! micropost_params
          data = Entities::Micropost.represent micropost
          message = "create micropost success"
          present response_success message, micropost: data
        end

        desc "Update micropost"
        params do
          requires :id, type: String, desc: "micropost ID"
          optional :micropost, type: Hash do
            optional :content, type: String, desc: "micropost content"
          end
        end
        patch ":id", root: :microposts do
          micropost = Micropost.find params[:id]
          micropost.update! params[:micropost]
          data = Entities::Micropost.represent micropost
          message = "update micropost success"
          present response_success message, micropost: data
        end

        desc "Delete micropost"
        params do
          requires :id, type: String, desc: "micropost ID"
        end
        delete ":id", root: :microposts do
          micropost = Micropost.find params[:id]
          micropost.destroy
          data = Entities::Micropost.represent micropost
          message = "destroy micropost success"
          present response_success message, micropost: data
        end
      end
    end
  end
end
