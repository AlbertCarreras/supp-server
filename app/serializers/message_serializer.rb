class MessageSerializer < ActiveModel::Serializer

  attributes :id, :conversation_id, :text, :created_at
  
  belongs_to :user, serializer: MessageUserSerializer

end
