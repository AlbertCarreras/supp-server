class Api::V1::ConversationsController < ApplicationController

    def index 

        conversations = Conversation.all

        render json: conversations

    end

    def create
        
        # 1. create a new conversation in the db.
        conversation = Conversation.new(conversation_params)
        
        # 2. if succesfully saved... get the serialized data for the conversation 
        if conversation.save
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
        params.require(:conversation).permit(:title)
    end

end