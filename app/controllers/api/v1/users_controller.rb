class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user,  only: [:update, :upload]
  
  # Find user and user methods from Active Storage for saving uploaded images.
  def upload

    user = User.find(photo_params[:user_id])
    
    user.profile_image.attach(photo_params[:profile_image])
    
    # @url = Rails.application.routes.url_helpers.rails_blob_path(@user.profile_image, only_path: true)

    #Resize returned image url using variant method.
    url = url_for(user.profile_image.variant(resize: "200x200"))
    
    json = {url: url, user_id: user.id}
    
    render json: json

  end
  
  # Update user information including geolocation coordinates.
  def update

    user = current_user

    if user.update(user_params)

      render json: {
        username: current_user.username,
        bio: current_user.bio,
        lat: current_user.last_location_lat,
        lon: current_user.last_location_lon,
      }

    end

  end

  private
  
  def user_params
    params.require(:user).permit(:user_id, :username, :email, :bio, :password, :password_confirmation, :profile_image, :last_location_lat, :last_location_lon)
  end
  
  def photo_params
    params.permit(:user_id, :profile_image)
  end
  
  def authorize
    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
  end
end
  