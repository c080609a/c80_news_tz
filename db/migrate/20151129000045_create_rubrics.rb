class CreateRubrics < ActiveRecord::Migration
  def change
    create_table :c80_news_tz_rubrics, :options => 'COLLATE=utf8_unicode_ci' do |t|
      t.string :title
      t.string :slug
      t.integer :ord

      t.timestamps null: false
    end
  end
end
