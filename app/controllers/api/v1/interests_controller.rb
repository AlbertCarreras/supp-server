class Api::V1::InterestsController < ApplicationController
    # before_action :authenticate_user,  only: [:index]
    
    def index
        @interests = InterestCategory.select { |m| 
        m.name.include? (user_params[:searchTerm])
        }
        @interests = @interests.sort_by { |m| m.name.downcase }
        render json: @interests
    end

    private

    def user_params
        params.require(:search).permit(:searchTerm)
    end

end
