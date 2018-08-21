class Api::V1::FriendsController < ApplicationController
    before_action :authenticate_user,  only: [:index, :filteredFriends ]

    def index
      
      users = User.select{|user| user.id != current_user.id}
      
      users = users.sort_by{|s| s.distance_to(current_user)}
      
      render json: users.map { |user|
        {
          "username" => user.username, 
          "email" => user.email, 
          "userId" => user.id, 
          "last_login" => user.last_login, 
          "bio" => user.bio, 
          "profileImageLink" => user.profile_image.attached? ? url_for(user.profile_image.variant(resize: "400x400")) : "undefined",
          "lat" => user.last_location_lat, 
          "lon" => user.last_location_lon,
          "interests" => user.interests,
          "distance" => user.distance_to(current_user)
        }
    }
    end

    def filteredFriends
      
      users = User.select{|user| user.id != current_user.id}
      
      users = users.select {|user| user.interest_ids.include?(friends_params[:filterId])}
      
      users = users.sort_by{|s| s.distance_to(current_user)}
      
      render json: users.map { |user|
        {
          "username" => user.username, 
          "email" => user.email, 
          "userId" => user.id, 
          "last_login" => user.last_login, 
          "bio" => user.bio, 
          "profileImageLink" => user.profile_image.attached? ? url_for(user.profile_image.variant(resize: "400x400")) : "undefined",
          "lat" => user.last_location_lat, 
          "lon" => user.last_location_lon,
          "interests" => user.interests,
          "distance" => user.distance_to(current_user)
        }
    }
    end
   
    private
   
    def user_params
      params.require(:user).permit(:user_id, :username, :email, :password, :password_confirmation, :profile_image, :last_location_lat, :last_location_lon)
    end

    def friends_params
      params.require(:filter).permit(:filterId)
    end

    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  