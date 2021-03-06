class User < ApplicationRecord

  has_many :user_interests
  has_many :user_conversations
  has_many :messages
  has_many :interests, through: :user_interests
  has_many :conversations, through: :user_conversations


  # Necessary to photo upload.
  has_one_attached :profile_image

  # Necessary to authenticate.
  has_secure_password
  
  # Necessary for gem 'geokit-rails'
  acts_as_mappable  :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :last_location_lat,
                    :lng_column_name => :last_location_lon
  
  # Basic password validation, configure to your liking.
  validates_length_of :password, maximum: 72, minimum: 8, allow_nil: true, allow_blank: false
  validates_confirmation_of :password, allow_nil: true, allow_blank: false
  before_validation {
    (self.email = self.email.to_s.downcase) && (self.username = self.username.to_s.downcase)
  }

  # Make sure email and username are present and unique.
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :email

  # This method gives us a simple call to check if a user has permission to modify.
  def can_modify_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  # This method tells us if the user is an admin or not.
  def is_admin?
    role == 'admin'
  end

end
