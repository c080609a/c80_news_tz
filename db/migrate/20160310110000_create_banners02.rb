class CreateBanners02 < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_banner02s, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :image
      t.string :href
      t.boolean :is_active
      t.integer :shown, :default => 0
      t.integer :clicks, :default => 0

      t.timestamps
    end
  end
end