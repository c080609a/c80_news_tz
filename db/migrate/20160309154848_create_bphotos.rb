class CreateBphotos < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_r_bphotos, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :image
      t.references :r_blurb, :index => true

      t.timestamps
    end
  end
end