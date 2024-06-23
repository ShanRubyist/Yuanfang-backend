Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers:
    { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # root "users/sessions#new"
  # Defines the root path route ("/")
  root "users/sessions#new"

  post 'token', to: 'users/omniauth_callbacks#token'

  post 'stripe_checkout', to: 'payment#stripe_checkout', as: 'stripe_checkout'
  get 'stripe_billing', to: 'payment#stripe_billing', as: 'billing'
  post 'paddle_customer', to: 'payment#paddle_customer', as: 'paddle_customer'
  get 'charges_history', to: 'payment#charges_history', as: 'charges_history'


  namespace :api do
    namespace :v1 do
      get 'user_info',to: 'info#user_info'
      get 'payment_info',to: 'info#payment_info'
      get 'active_subscription_info', to: 'info#active_subscription_info', as: 'active_subscription_info'

      resources :prompts do
        collection do
          get 'default' => 'prompts#get_default_prompt'
          post 'default' => 'prompts#set_default_prompt'
        end
      end

      # match "*path", to: "api#gone", via: :all
      resources :completions do
        collection do
          post 'achieve' => 'completions#achieve', as: 'achieve'
        end
      end

      resources :info do
        collection do
          get 'models' => "info#models", as: 'models'
        end
      end
    end
  end

  # 跨域预检请求
  match '*all', controller: 'application', action: 'cors_preflight_check', via: [:options]
end
