class Api::V1::InterestsController < ApplicationController
    # before_action :authenticate_user,  only: [:index]
    
    def index
      # Find interests that match the search. Search passed as params. 
        interests = Interest.select { |m| 
            m.name.include? (user_params[:searchTerm])
        }

      # Return an alphabetically-sorted array. 
        interests = interests.sort_by { |m| m.name.downcase }
        
        render json: interests
    end

    def create
        # Add a new interest to database if it didn't exist previously. Downcase all letters and remove blank spaces from sides before saving. 
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
