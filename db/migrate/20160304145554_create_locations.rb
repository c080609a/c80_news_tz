class CreateLocations < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_locations, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :tag

      t.timestamps null: false
    end
  end
end
