class CreateGphotos < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_gphotos, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :image
      t.string :title
      t.references :gallery, index: true

      t.timestamps null: false
    end
    # add_foreign_key :c80_news_tz_gphotos, :galleries
  end
end
