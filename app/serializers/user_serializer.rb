class UserSerializer < ActiveModel::Serializer
  
  attributes :id, :username, :date_of_birth, :bio, :last_location_lat, :last_location_lon, :last_zipcode, :active_user

  has_many :interest_categories, through: :user_interests
end
