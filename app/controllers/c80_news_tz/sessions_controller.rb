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

      # Rails.logger.debug("<SessionsController.create> request.env['omniauth.origin'] = " + request.env['omniauth.origin'])
      redirect_to request.env['omniauth.origin']

    end

    def destroy
      #if current_user
      begin
        session.delete(:user_id)
      rescue
      end

      flash[:success] = 'See you!'

      redirect_to request.referer

    end

    def auth_failure
      # redirect_to request.referer
      redirect_to request.env['omniauth.origin']
    end

  end

end