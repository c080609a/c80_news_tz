module C80NewsTz
  class SessionsController < ApplicationController

    def create
      #render text: request.env['omniauth.auth'].to_yaml

      begin
        @user = User.from_omniauth(request.env['omniauth.auth'])
        session[:user_id] = @user.id
        flash[:success] = "Welcome, #{@user.name}!"
      rescue => e
        Rails.logger.debug(e)
        flash[:warning] = 'There was an error while try to authenticate you...'
      end

      # redirect_to request.referer

    end

    def destroy
      if current_user
        session.delete(:user_id)
        flash[:success] = 'See you!'
      end

      redirect_to request.referer

    end

  end

end