class UserInterest < ApplicationRecord

    belongs_to :user
    belongs_to :interest_category

end
