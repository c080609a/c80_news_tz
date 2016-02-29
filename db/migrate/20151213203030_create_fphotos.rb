class CreateFphotos < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_fphotos, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :image
      t.references :fact, index: true

      t.timestamps null: false
    end

  end
end