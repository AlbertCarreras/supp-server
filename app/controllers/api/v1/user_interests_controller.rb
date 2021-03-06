class Api::V1::UserInterestsController < ApplicationController
  before_action :authenticate_user,  only: [:update, :destroy]
  
  # Add a user's new selected interest. 
  def create

    if !params["user"]["interests"].nil?

      UserInterest.create(user_id: current_user.id, interest_id: params["user"]["interests"]["id"])

    end

    render json: {
      interests: current_user.interests
    }

  end

  # Remove a user's interest. 
  def destroy

    if !params["user"]["interests"].nil?

      UserInterest.find_by(user_id: current_user.id, interest_id: params["user"]["interests"]["id"]).delete

      render json: {
        interests: current_user.interests
      }
      
    end

  end

    private
    
    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  