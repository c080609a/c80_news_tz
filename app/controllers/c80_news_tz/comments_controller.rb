module C80NewsTz
  class CommentsController < ApplicationController

    def create

      mark_spam = false
      time_delta = 0

      if session['last_comment_ts'].present?
        time_delta = Time.now.to_i - session['last_comment_ts']
        mark_spam = time_delta < 30
      end

      if mark_spam
        respond_to do |format|
          @time_elapsed = 30 - time_delta
          format.js { render :action => 'antispam' }
        end
      else
        @comment = Comment.create(comment_params)
        if @comment.save
          session['last_comment_ts'] = Time.now.to_i
          @comments_count = @comment.blurb_or_fact.comments.count
          respond_to do |format|
            format.js { render :action => 'created'}
          end
        else
          respond_to do |format|
            format.js { render :json => @comment.errors }
          end
        end
      end

    end

    def comment_params
      params.require(:comment).permit(:message, :user_id, :fact_id, :r_blurb_id)
    end

  end
end