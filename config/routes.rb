Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # root "users/sessions#new"

  namespace :api do
    namespace :v1 do
      # match "*path", to: "api#gone", via: :all
      resources :completions do
        collection do
          post 'achieve' => 'completions#achieve', as: 'achieve'
        end
      end
    end
  end

  # 跨域预检请求
  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]
end
