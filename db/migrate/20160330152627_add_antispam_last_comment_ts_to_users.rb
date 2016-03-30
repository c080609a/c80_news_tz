class AddAntispamLastCommentTsToUsers < ActiveRecord::Migration
  def change

      #remove_column :c80_news_tz_users, :last_comment_ts
      add_column :c80_news_tz_users, :last_comment_ts, :integer

  end
end
