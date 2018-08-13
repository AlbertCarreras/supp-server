class Api::V1::UserInterestsController < ApplicationController
    before_action :authenticate_user,  only: [:update]
    
    def update
      @user = current_user
        render json: {
          username: current_user.username,
          bio: current_user.bio,
          lat: current_user.last_location_lat,
          lon: current_user.last_location_lon,
        }
    end

    private
    
    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  