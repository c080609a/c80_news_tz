class CreateIssues < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_issues, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
