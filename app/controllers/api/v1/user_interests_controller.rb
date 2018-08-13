class Api::V1::UserInterestsController < ApplicationController
    before_action :authenticate_user,  only: [:update]
    
    def update
      if !params["user"]["interests"].nil?
      UserInterest.create(user_id: current_user.id, interest_id: params["user"]["interests"]["id"])
      end
        render json: {
          interests: current_user.interests
        }
    end

    private
    
    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  