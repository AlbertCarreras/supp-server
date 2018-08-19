class Api::V1::ConversationsController < ApplicationController
    before_action :authenticate_user,  only: [:index, :create]

    def index 
        conversations = Conversation.select { |conversation| conversation.user_ids.include?(current_user.id)} 
        
        render json: conversations, include: "users,messages,messages.user"

    end

    def create
        
        # 1. create a new conversation in the db.
        conversation = Conversation.new(conversation_params)

        # 2. if succesfully saved... get the serialized data for the conversation 
        if conversation.save

            # 2.1. create a user_conversation in the db for each user.
            ownership1 = UserConversation.new()
            ownership1.conversation_id = conversation.id
            ownership1.user_id = params["sender_id"]
            ownership1.save
            ownership2 = UserConversation.new()
            ownership2.conversation_id = conversation.id
            ownership2.user_id = params["receiver_id"]
            ownership2.save

            serialized_data = ActiveModelSerializers::Adapter::Json.new(
                ConversationSerializer.new(conversation)
            ).serializable_hash
            
             # 3. then send back the serialized data to subscribers.
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