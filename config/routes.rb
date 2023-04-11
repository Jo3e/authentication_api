Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1, defaults: {format: :json} do
      resources :users
      post '/auth/login', to: 'authentication#login'
      post '/auth/signup', to: 'authentication#signup'

    end
  end
end
