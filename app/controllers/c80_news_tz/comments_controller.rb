module C80NewsTz
  class CommentsController < ApplicationController

    def create
      @comment = Comment.create(comment_params)
      if @comment.save
        respond_to do |format|
          format.js { render :action => 'created'}
        end
      else
        respond_to do |format|
          format.js { render :json => @comment.errors }
        end
      end
    end

    def comment_params
      params.require(:comment).permit(:message, :user_id, :fact_id, :r_blurb_id)
    end

  end
end