class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_user,  only: [:create]

    def create

      # 1. create a new message in the db.
      message = Message.new(message_params)
      message.user_id = current_user.id
    
      conversation = Conversation.find(message_params[:conversation_id])
      
      # 2. if succesfully saved... get the serialized data for the message 
      if message.save
        serialized_data = ActiveModelSerializers::Adapter::Json.new(
          MessageSerializer.new(message)
        ).serializable_hash
        
        # 3. then send back the serialized data to subscribers.
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