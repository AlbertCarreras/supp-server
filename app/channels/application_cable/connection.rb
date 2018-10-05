module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
    private

    def find_verified_user
      # If passing cookies with JWT
      # if current_user = User.find_by(id: JWT.decode(cookies["X-Authorization"],"", false)[0]['sub'])
      
      # If passing JWT directly in the websocket connect request uri
      # if current_user = User.find_by(id: JWT.decode(request.params[:user],"", false)[0]['sub'])
      
      # If passing userId number directly in the websocket connect request uri
      if current_user = User.find_by(id: request.params[:user])
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end