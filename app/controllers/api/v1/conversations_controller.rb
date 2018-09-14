class Api::V1::ConversationsController < ApplicationController
    before_action :authenticate_user,  only: [:index, :create]

    def index 
        # Filter and return conversations where the current user is one of the users the conversations belong to.
        conversations = Conversation.select { |conversation| conversation.user_ids.include?(current_user.id)} 
        render json: conversations, include: "users,messages,messages.user"
    end

    def create
        
        # 1. Create a new conversation in the db.
        conversation = Conversation.new(conversation_params)

        if conversation.save

            # 2. Create each relationship between conversation and both users via join table user_conversation. Both conversation users are passed in params.
            ownership1 = UserConversation.new()
            ownership1.conversation_id = conversation.id
            ownership1.user_id = params["sender_id"]
            ownership1.save
            ownership2 = UserConversation.new()
            ownership2.conversation_id = conversation.id
            ownership2.user_id = params["receiver_id"]
            ownership2.save

            # 3. Get the serialized data for the conversation as defined in ConversationSerializer
            serialized_data = ActiveModelSerializers::Adapter::Json.new(
                ConversationSerializer.new(conversation)
            ).serializable_hash
            
             # 3. Broadcast new serialized converation to channel subscribers.
            ActionCable.server.broadcast(
                'conversations_channel', 
                serialized_data
            )
            head :ok 
        end
    end

    private
  
    def conversation_params
        params.require(:conversation).permit(:title, :sender_id, :receiver_id)
    end
    
end