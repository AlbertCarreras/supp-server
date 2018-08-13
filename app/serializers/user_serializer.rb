class UserSerializer < ActiveModel::Serializer
  
  attributes :id, :email, :username, :role, :created_at, :updated_at, :last_login, :date_of_birth, :bio, :last_location_lat, :last_location_lon, :last_zipcode, :active_user, :profile_image

  has_many :interests, through: :user_interests

end
