class Api::V1::UsersController < ApplicationController
    # Use Knock to make sure the current_user is authenticated before completing request.
    before_action :authenticate_user,  only: [:current, :update, :auth]
    before_action :authorize_as_admin, only: [:destroy]
    before_action :authorize,          only: [:update]
   
    # Should work if the current_user is authenticated.
    def index
      @users = User.all
      render json: @users
    end
   
    # Call this method to check if the user is logged-in.
    # If the user is logged-in we will return the user's information.
    def current
      current_user.update!(last_login: Time.now)
      render json: current_user
    end

    # Method to create a new user using the safe params we setup.
    def create
      user = User.new(user_params)
      if user.save
        render json: {status: 200, msg: 'User was created.'}
      end
    end

    # Method to update a specific user. User will need to be authorized.
    def upload
      @user = User.find(photo_params[:user_id])
      @user.profile_image.attach(photo_params[:profile_image])
      # @url = Rails.application.routes.url_helpers.rails_blob_path(@user.profile_image, only_path: true)
      @url = url_for(@user.profile_image.variant(resize: "200x200"))
      @json = {url: @url, user_id: @user.id}
        render json: @json
    end
    
    # Method to upload a photo. User will need to be authorized.
    def update
      user = User.find(params[:user_id])
      if user.update(user_params)
        render json: { status: 200, msg: 'User details have been updated.' }
      end
    end

    # Method to delete a user, this method is only for admin accounts.
    def destroy
      user = User.find(user_params[:id])
      if user.destroy
        render json: { status: 200, msg: 'User has been deleted.' }
      end
    end

    # Authorized only method
    def auth
      render json: {
        username: current_user.username,
        id: current_user.id,
        email: current_user.email,
        profile_image: url_for(current_user.profile_image.variant(resize: "200x200"))
      }
    end
   
    private
   
    # Setting up strict parameters for when we add account creation.
    def user_params
      params.require(:user).permit(:user_id, :username, :email, :password, :password_confirmation, :profile_image)
    end
    def photo_params
      params.permit(:user_id, :profile_image)
    end
    
    # Adding a method to check if current_user can update itself.
    # This uses our UserModel method.
    def authorize
      return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
    end
end
  