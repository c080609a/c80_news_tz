class CreateNotices < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_notices, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :slug
      t.string :place
      t.text :desc
      t.text :custom_org

      t.timestamps null: false
    end
  end
end
