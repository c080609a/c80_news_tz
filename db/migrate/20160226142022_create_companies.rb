class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_companies, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :activity_type
      t.text :desc
      t.string :slug
      t.string :logo

      t.timestamps
    end
  end
end