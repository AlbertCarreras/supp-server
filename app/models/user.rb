class User < ApplicationRecord

    has_many :user_interests
    has_many :interest_categories, through: :user_interests
    has_many :user_activities

end
