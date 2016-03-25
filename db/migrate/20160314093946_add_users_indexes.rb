class AddUsersIndexes < ActiveRecord::Migration
  def change

      add_index :c80_news_tz_users, :provider
      add_index :c80_news_tz_users, :uid
      add_index :c80_news_tz_users, [:provider, :uid], unique: true

  end
end
