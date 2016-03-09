class CreateBlurbs < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_r_blurbs, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :sub_title
      t.text :short
      t.text :leader_abz
      t.text :full
      t.string :slug

      t.timestamps
    end
  end
end