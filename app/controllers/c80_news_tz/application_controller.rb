module C80NewsTz
  class ApplicationController < ActionController::Base

    def guru
      respond_to do |format|
        format.js
      end
    end
  end
end
