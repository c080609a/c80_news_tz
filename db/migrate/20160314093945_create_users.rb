class CreateUsers < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_users, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name
      t.string :location
      t.string :image_url
      t.string :url

      t.timestamps null: false
    end
  end
end
