module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
    private

    def find_verified_user
      # cookies["X-Authorization"] >> unused
      # if current_user = User.find_by(id: request.params[:user])
      if current_user = User.find_by(id: JWT.decode(request.params[:user],"", false)[0]['sub'])
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end