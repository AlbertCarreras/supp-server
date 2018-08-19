class ConversationUserSerializer < ActiveModel::Serializer

  include Rails.application.routes.url_helpers

  attributes :id, :username, :profile_image_url

  def profile_image_url
    variant = object.profile_image.variant(resize: "100x100")
    return rails_representation_url(variant, only_path: true)
  end

end
