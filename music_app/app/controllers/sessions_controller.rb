class SessionsController < ApplicationController

    def create 
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if @user 
            #login
            session[:session_token] = @user.reset_session_token!
            redirect_to user_url(@user.id)
        else   
            render :new 
        end

    end


end