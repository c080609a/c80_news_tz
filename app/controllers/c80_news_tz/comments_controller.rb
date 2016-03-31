module C80NewsTz
  class CommentsController < ApplicationController

    before_action :check_comments_enabled

    def create

      mark_spam = false
      time_delta = 0
      user = User.find(params[:comment][:user_id])

      # проверим, не спамер ли это?
      unless user.last_comment_ts.nil?
        time_delta = Time.now.to_i - user.last_comment_ts
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
          update_user_last_comment(user)
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

    private

    def comment_params
      params.require(:comment).permit(:message, :user_id, :fact_id, :r_blurb_id)
    end


    def update_user_last_comment(user)
      user.last_comment_ts = Time.now.to_i
      user.save
    end

    def check_comments_enabled
      comments_enabled = CommentsProps.find(1).comments_enabled
      unless comments_enabled
        respond_to do |format|
          format.js { render :action => 'comments_disabled' }
        end
      end
    end

  end
end