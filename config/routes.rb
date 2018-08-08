Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :user_activities
      # resources :user_interests
      # resources :interest_categories
      # resources :users 
      get '/' => 'users#index' 
      get '/categories' => 'interest_categories#index' 

    end
  end
end


