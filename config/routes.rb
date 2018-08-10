Rails.application.routes.draw do
  # Get login token from Knock
  # post 'user_token' => 'user_token#create'

  namespace :api do
    namespace :v1 do
      #Page setup
      get '/categories' => 'interest_categories#index' 
      get '/users' => 'users#index'

      # User no-action data
      get '/user/auth' => 'users#auth'
      post '/users/create' => 'users#create'
      post 'user_token' => 'user_token#create' # Get login token from Knock

      # User action data
      post '/users/uploadProfile' => 'users#upload'
      patch '/user/:id' => 'users#update'

      #UNUSED
      # get '/users/current' => 'users#current'
      # delete '/user/:id' => 'users#destroy'
      
    end
  end
end


