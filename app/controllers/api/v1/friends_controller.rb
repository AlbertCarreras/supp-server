class Api::V1::FriendsController < ApplicationController
    before_action :authenticate_user,  only: [:index, :filteredFriends ]

    def index
      if current_user.last_location_lat
      # Select all users except the current user. 
      users = getFriends()
      
      # Sort users by distance to current user using Geokit-provided properties.  
      users = sortFriends(users)
      
      #Map users and for each build a hash with user information 
      render json: mapFriends(users)
      end
    end

    def filteredFriends
      # Select all users except the current user. 
      users = getFriends()
      
      # Filter users that also have the searched interest. 
      users = users.select {|user| user.interest_ids.include?(friends_params[:filterId])}
      
      # Sort users by distance to current user using Geokit-provided properties.  
      users = sortFriends(users)
      
      render json: mapFriends(users)
    end
   
    private

    def getFriends
      # Select and return all users except the current user. 
      users = User.select{|user| user.id != current_user.id}

      return users
    end

    def sortFriends(users)
      # Select and return all users except the current user. 
      sortedUsers = users.sort_by{|s| s.distance_to(current_user)}

      return sortedUsers
    end

    def mapFriends(users)
      # Map users and return a hash for each user with their data
      users.map { |user|
        {
          "username" => user.username, 
          "email" => user.email, 
          "userId" => user.id, 
          "active_user" => user.active_user,
          "bio" => user.bio, 
          "profileImageLink" => user.profile_image.attached? ? url_for(user.profile_image.variant(resize: "400x400")) : "undefined",
          "lat" => user.last_location_lat, 
          "lon" => user.last_location_lon,
          "interests" => user.interests,
          "distance" => user.distance_to(current_user)
        }
    }
    end
   
    # STRONG PARAMS
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
  