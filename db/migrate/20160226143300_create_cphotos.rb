class CreateCphotos < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_cphotos, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :image
      t.references :company, :index => true

      t.timestamps
    end
  end
end