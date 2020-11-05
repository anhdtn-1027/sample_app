require "swagger_helper"

JWT_TOKEN="eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.9LNQ6hfOcGF7jmwKYmxZdQOmzET3h8ixKK5n7V4qvL8"

describe "User API" do
  path "/v1/auth/sign_in" do
    post "User sign_in" do
      consumes "application/json"

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: {type: :string},
          password: {type: :string},
        },
        required: %i(email password)
      }
      response "200", "Login success" do
        let(:params) { {email: "example@railstutorial.org", password: "foobar"} }
        run_test! do |response|
          data = JSON.parse response.body
          expect(data["jwt_token"]).to eq(JWT_TOKEN)
        end
      end

      response "400", "Bad request" do
        schema type: :object
        let(:params) { {email: "example@railstutorial.org"} }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({
            "status": "error",
            "errors": "password is missing"
        })
        end
      end

      response "401", "Unauthorized" do
        schema type: :object
        let(:params) { {email: "example@railstutorial.org", "password": nil} }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({
            "status": "error",
            "errors": "Invalid email/password combination"
        })
        end
      end
    end
  end

  path "/v1/users/" do
    get "GET all users" do
      tags "Users"
      produces "application/json", "application/xml"
      parameter name: :"Jwt-Token", :in => :header, :type => :apiKey
      security [JWT_token: {}]

      response "200", "GET users success" do
        let(:"Jwt-Token") { JWT_TOKEN }
        run_test! do |response|
          data = JSON.parse response.body
          expect(data["status"]).to eq("success")
        end
      end

      response "404", "Error: Not Found" do
        let(:"JWT-Token") { nil }
        run_test! do |response|
          data = JSON.parse response.body
          expect(data).to eq({
            "status": "error",
            "errors": "Couldn't find User without an ID"
          })
        end
      end

      response "500", "Error: Internal Server Error" do
        let(:"JWT-Token") { "string_fail" }
        run_test! do |response|
          data = JSON.parse response.body
          expect(data).to eq({
            "status": "error",
            "errors": "Not enough or too many segments"
          })
        end
      end
    end
  end

  path "/v1/users/{id}" do
    get "GET user detail" do
      tags "Users"
      produces "application/json", "application/xml"
      parameter name: :id, :in => :path, :type => :integer
      parameter name: :"Jwt-Token", :in => :header, :type => :apiKey
      security [JWT_token: {}]

      response "200", "user found" do
        schema type: :object,
        properties: {
          id: { type: :integer }
        },
        required: [ :id ]

        let(:id) { 1 }
        let(:"Jwt-Token") { JWT_TOKEN }
        run_test!
      end

      response "404", "Error: Not Found" do
        schema type: :object,
        properties: {
          id: { type: :integer }
        },
        required: [ :id ]

        let(:id) { 10000 }
        let(:"Jwt-Token") { JWT_TOKEN }
        run_test! do |response|
          data = JSON.parse response.body
          expect(data).to eq({
            "status": "error",
            "errors": "Couldn't find User with 'id'=10000"
          })
        end
      end

      response "500", "Error: Internal Server Error" do
        schema type: :object,
        properties: {
          id: { type: :integer }
        },
        required: [ :id ]

        let(:id) { 1 }
        let(:"JWT-Token") { "string_fail" }
        run_test! do |response|
          data = JSON.parse response.body
          expect(data).to eq({
            "status": "error",
            "errors": "Not enough or too many segments"
          })
        end
      end
    end
  end
end
