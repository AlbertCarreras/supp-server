class Api::V1::UserInterestsController < ApplicationController
    before_action :authenticate_user,  only: [:update]

    def update
        @user = current_user
        if !params["user"]["interests"].nil?
          params["user"]["interests"].each { |a| UserInterest.create(user_id: current_user.id, interest_id: a["id"])}
        end
  
        render json: {
        username: current_user.username,
        bio: current_user.bio,
        lat: current_user.last_location_lat,
        lon: current_user.last_location_lon,
        userInterests: current_user.interests
        }
      end

    private

    def user_params
        params.require(:search).permit(:searchTerm)
    end

end
