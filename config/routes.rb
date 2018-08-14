Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      #Page setup
      post '/searchInterests' => 'interests#index' 
      get '/users' => 'friends#index'
      post '/users' => 'friends#filteredFriends'

      # User no-action data
      get '/user/auth' => 'sessions#auth'
      post '/users/create' => 'sessions#create'
      post 'user_token' => 'user_token#create' # Get login token from Knock

      # User action data
      post '/users/uploadProfile' => 'users#upload'
      patch '/user/:id' => 'users#update'
      post '/user/:id/interests' => 'user_interests#update'
      delete '/user_interests/:id' => 'user_interests#destroy'

      #UNUSED
      # get '/users/current' => 'users#current'
      # delete '/user/:id' => 'users#destroy'
      
    end
  end
end


