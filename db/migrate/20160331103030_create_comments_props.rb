class CreateCommentsProps < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_comments_props, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.integer :anitspam_delay
      t.boolean :comments_enabled

      t.timestamps null: false
    end
  end
end
