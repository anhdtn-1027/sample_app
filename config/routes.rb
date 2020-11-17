Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  mount API::Base, at: "/"

  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/help", to: "static_pages#help"
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    get ":id/following", to: "following#index", as: "following"
    get ":id/followers", to: "followers#index", as: "followers"
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: "sessions",
      registrations: "registrations",
      confirmations: "confirmations",
      passwords: "passwords"
    }

    resources :users, except: %i(new create)
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
  end
end
