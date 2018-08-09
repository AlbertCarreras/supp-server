Rails.application.routes.draw do
  # Get login token from Knock
  # post 'user_token' => 'user_token#create'

  namespace :api do
    namespace :v1 do
      # User actions
      get '/user/auth' => 'users#auth'
      get '/users' => 'users#index'
      get '/users/current' => 'users#current'
      post '/users/create' => 'users#create'
      patch '/user/:id' => 'users#update'
      delete '/user/:id' => 'users#destroy'
      
      # Get login token from Knock
      post 'user_token' => 'user_token#create'

      get '/categories' => 'interest_categories#index' 

    end
  end
end


