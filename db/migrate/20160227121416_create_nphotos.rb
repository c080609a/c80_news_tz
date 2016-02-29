class CreateNphotos < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_nphotos, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :image
      t.references :notice, :index => true

      t.timestamps
    end
  end
end