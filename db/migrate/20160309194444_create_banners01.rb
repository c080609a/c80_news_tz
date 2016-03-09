class CreateBanners01 < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_banner01s, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :image
      t.string :href
      t.boolean :is_active

      t.timestamps
    end
  end
end