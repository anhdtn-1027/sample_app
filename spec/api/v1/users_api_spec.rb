require "swagger_helper"

describe "User API" do
  path "api/v1/sign_in" do
    post "User sign_in" do
      consumes "application/json", "application/xml"

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: {type: :string},
          password: {type: : password},
        },
        required: %i(email password),
        example: {
          email: "example@railstutorial.org",
          password: "foobar"
        }
      }
      response "200", "Login success" do
        schema type: :object,
        
        let(:params) do
          {
            email: "example@railstutorial.org",
            password: "foobar"
          }
        end
        run_test!
      end
    end
  end
end
