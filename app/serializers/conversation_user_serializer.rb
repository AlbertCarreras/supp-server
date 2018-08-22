class ConversationUserSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :username, :bio, :interests, :active_user, :profile_image_url

  def profile_image_url
    variant = object.profile_image.variant(resize: "200x200")
    return rails_representation_url(variant, only_path: true)
  end

  def distance
    # return object.distance_to(current_user)
  end

end
