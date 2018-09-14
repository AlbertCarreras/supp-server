class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_user,  only: [:create]

    def create

      # 1. Create a new message in the db. The message belongs to current user.
      message = Message.new(message_params)
      message.user_id = current_user.id
    
      # 2. Find conversations to which the message belongs to.
      conversation = Conversation.find(message_params[:conversation_id])
      
      # 3. If the message gets succesfully saved, then get the serialized data for the message as defined in MessageSerializer
      if message.save
        serialized_data = ActiveModelSerializers::Adapter::Json.new(
          MessageSerializer.new(message)
        ).serializable_hash
        
        # 4. Broadcast new serialized message to conversation subscribers.
        MessagesChannel.broadcast_to(
          conversation, 
          serialized_data
        )
        head :ok
      end
    end
    
    private
    
    def message_params
      params.require(:message).permit(:text, :conversation_id)
    end
  end