class Api::V1::SessionsController < ApplicationController
    before_action :authenticate_user,  only: [:auth]
   
    # Method to create a new user using the safe params we setup.
    def create
      user = User.new(user_params)
      if user.save
        render json: {status: 200, msg: 'User was created.'}
      end
    end
    
    def auth
      if current_user.profile_image.attached?
          if current_user.last_location_lat
            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
              bio: current_user.bio,
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
              profile_image: url_for(current_user.profile_image.variant(resize: "200x200"))
            }
          end
      else 
          if current_user.last_location_lat
            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
              lat: current_user.last_location_lat,
              lon: current_user.last_location_lon,
            }
          else 
            render json: {
              username: current_user.username,
              id: current_user.id,
              email: current_user.email,
            }
          end
      end
    end
   
    private
   
    # Setting up strict parameters for when we add account creation.
    def user_params
      params.require(:user).permit(:user_id, :username, :email, :password, :password_confirmation, :profile_image, :last_location_lat, :last_location_lon)
    end

    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  