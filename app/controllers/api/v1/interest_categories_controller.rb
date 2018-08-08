class Api::V1::InterestCategoriesController < ApplicationController
    def index
        @interest_categories = InterestCategory.all 
        render json: @interest_categories
    end
end
