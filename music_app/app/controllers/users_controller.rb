class UsersController < ApplicationController

    def new 
        @user = User.new
        render :new 
    end

    def show 
        @user = User.find(params[:id])
        render :show
    end

    def create 
        @user = User.new(user_params)

        if @user.save
            login(@user)
            redirect_to user_url(@user.id)
        else  
            render json: @user.errors.full_messages, status: 422
        end
    end



    def user_params
        params.require(:user).permit(:email, :password)
    end

end