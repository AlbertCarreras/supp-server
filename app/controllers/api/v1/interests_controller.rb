class Api::V1::InterestsController < ApplicationController
    # before_action :authenticate_user,  only: [:index]
    
    def index
        interests = Interest.select { |m| 
            m.name.include? (user_params[:searchTerm])
        }
        
        interests = interests.sort_by { |m| m.name.downcase }
        
        render json: interests
    end

    def create
        newInterest = Interest.new(name: interest_params[:newTerm].downcase.strip)
        
        if newInterest.save         
            render json: newInterest
        end

    end

    private

    def user_params
        params.require(:search).permit(:searchTerm)
    end

    def interest_params
        params.require(:interest).permit(:newTerm)
    end

end
