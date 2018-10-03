class Api::V1::SessionsController < ApplicationController
    before_action :authenticate_user,  only: [:auth]
   
    # Create a new user using the strong params.
    def create
      
      user = User.new(user_params)

      if user.save

        render json: {status: 200, msg: 'User was created.'}

      else 
        render json: {
          errors: user.errors.full_messages
        }, status: :unprocessable_entity

      end

    end
    
    # If authorized, return the logged-in user information based on different conditionals:
    # user has profile image and previous geolocation coordinates. 
    def auth

      if current_user.profile_image.attached?

          if current_user.last_location_lat

            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
              bio: current_user.bio,
              userInterests: current_user.interests,
              lat: current_user.last_location_lat,
              lon: current_user.last_location_lon,
              profile_image: url_for(current_user.profile_image.variant(resize: "200x200"))
            }

          else 

            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
              bio: current_user.bio,
              userInterests: current_user.interests,
              profile_image: url_for(current_user.profile_image.variant(resize: "200x200"))
            }

          end

      else 

          if current_user.last_location_lat

            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
              bio: current_user.bio,
              userInterests: current_user.interests,
              lat: current_user.last_location_lat,
              lon: current_user.last_location_lon,
            }

          else 

            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
              bio: current_user.bio,
              userInterests: current_user.interests,
            }

          end
          
      end

    end
   
    private
   
    def user_params
      params.require(:user).permit(:user_id, :username, :email, :password, :password_confirmation, :profile_image, :last_location_lat, :last_location_lon)
    end

    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  