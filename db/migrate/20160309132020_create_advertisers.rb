# рекламодатель
class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_r_advertisers, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :slug
      t.string :logo

      t.timestamps null: false
    end
  end
end
