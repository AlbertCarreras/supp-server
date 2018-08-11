class Api::V1::UsersController < ApplicationController
    before_action :authenticate_user,  only: [:index, :update, :upload]

    def index
      @users = User.all
      render json: @users.map { |user|
        {
          "username" => user.username, 
          "email" => user.email, 
          "userId" => user.id, 
          "last_login" => user.last_login, 
          "bio" => user.bio, 
          "profileImageLink" => user.profile_image.attached? ? url_for(user.profile_image.variant(resize: "200x200")) : "undefined", 
          "lat" => user.last_location_lat, 
          "lon" => user.last_location_lon, 
        }
    }
    end
   
    def upload
      @user = User.find(photo_params[:user_id])
      @user.profile_image.attach(photo_params[:profile_image])
      # @url = Rails.application.routes.url_helpers.rails_blob_path(@user.profile_image, only_path: true)
      @url = url_for(@user.profile_image.variant(resize: "200x200"))
      @json = {url: @url, user_id: @user.id}
        render json: @json
    end
    
    def update
      user = current_user
      if user.update(user_params)
        render json: {
          lat: current_user.last_location_lat,
          lon: current_user.last_location_lon,
        }
      end
    end

    private
   
    def user_params
      params.require(:user).permit(:user_id, :username, :email, :password, :password_confirmation, :profile_image, :last_location_lat, :last_location_lon)
    end
    def photo_params
      params.permit(:user_id, :profile_image)
    end
    
    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  