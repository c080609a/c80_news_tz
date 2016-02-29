class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_galleries, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :tag
      t.references :company, :index => true
      t.references :notice, :index => true

      t.timestamps null: false
    end
  end
end
